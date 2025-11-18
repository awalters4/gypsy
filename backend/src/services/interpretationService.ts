import Anthropic from '@anthropic-ai/sdk';
import pool from '../database/db';

const anthropic = new Anthropic({
  apiKey: process.env.ANTHROPIC_API_KEY,
});

interface CardInReading {
  cardId: number;
  position: number;
  reversed: boolean;
}

export type TonePreference = 'warm' | 'direct' | 'mystical' | 'analytical';

interface CardContext {
  position: string;
  positionMeaning: string;
  card: string;
  reversed: boolean;
  meaning: string;
  keywords: string[];
}

interface InterpretationContext {
  spread: any;
  cardsContext: CardContext[];
  pastReadingsContext: string;
  pastReadingsCount: number;
}

// Fetch context for interpretation (reusable across streaming and non-streaming)
export async function getInterpretationContext(
  spreadTypeId: number,
  deckId: number,
  cardsDrawn: CardInReading[]
): Promise<InterpretationContext> {
  // Fetch spread type details
  const spreadResult = await pool.query(
    'SELECT * FROM spread_types WHERE id = $1',
    [spreadTypeId]
  );
  const spread = spreadResult.rows[0];

  if (!spread) {
    throw new Error(`Spread type with ID ${spreadTypeId} not found`);
  }

  // Fetch card details
  const cardIds = cardsDrawn.map(c => c.cardId);
  const cardsResult = await pool.query(
    `SELECT
      c.id, c.name, c.number, c.suit, c.card_type, c.archetype,
      cm.upright_meaning, cm.reversed_meaning,
      cm.upright_keywords, cm.reversed_keywords
    FROM cards c
    LEFT JOIN card_meanings cm ON c.id = cm.card_id
    WHERE c.id = ANY($1) AND cm.deck_id = $2`,
    [cardIds, deckId]
  );

  // Build context for AI
  const cardsContext = cardsDrawn.map(drawnCard => {
    const card = cardsResult.rows.find(c => c.id === drawnCard.cardId);

    // Validate card exists
    if (!card) {
      throw new Error(`Card with ID ${drawnCard.cardId} not found`);
    }

    // Validate position is within bounds
    if (!spread.positions || drawnCard.position > spread.positions.length || drawnCard.position < 1) {
      throw new Error(`Invalid position ${drawnCard.position} for spread ${spread.name}`);
    }

    const position = spread.positions[drawnCard.position - 1];

    return {
      position: position.name,
      positionMeaning: position.meaning,
      card: card.name,
      reversed: drawnCard.reversed,
      meaning: drawnCard.reversed ? card.reversed_meaning : card.upright_meaning,
      keywords: drawnCard.reversed ? card.reversed_keywords : card.upright_keywords,
    };
  });

  // Fetch past successful readings for context (learning component)
  const pastReadingsResult = await pool.query(
    `SELECT r.interpretation, r.question, rf.accuracy_rating, rf.resonance_rating
     FROM readings r
     JOIN reading_feedback rf ON r.id = rf.reading_id
     WHERE rf.accuracy_rating >= 4 OR rf.resonance_rating >= 4
     ORDER BY r.created_at DESC
     LIMIT 3`
  );

  const pastReadingsContext = pastReadingsResult.rows.length > 0
    ? `\n\nHere are some examples of past readings that resonated well:\n${pastReadingsResult.rows
        .map(r => `Q: ${r.question}\nInterpretation: ${r.interpretation}`)
        .join('\n\n')}`
    : '';

  return {
    spread,
    cardsContext,
    pastReadingsContext,
    pastReadingsCount: pastReadingsResult.rows.length,
  };
}

// Build the prompt for Claude
function buildPrompt(
  context: InterpretationContext,
  question?: string,
  tone: TonePreference = 'warm'
): string {
  const { spread, cardsContext, pastReadingsContext } = context;

  const toneInstructions = {
    warm: 'warm, thoughtful, and empowering',
    direct: 'direct, practical, and straightforward',
    mystical: 'mystical, poetic, and spiritually evocative',
    analytical: 'analytical, psychological, and introspective',
  };

  return `You are an experienced tarot reader. Provide a thoughtful, insightful interpretation for this ${spread.name} reading.

${question ? `Question: ${question}\n` : ''}
Spread: ${spread.name}
${spread.description ? `Spread Description: ${spread.description}\n` : ''}

Cards drawn:
${cardsContext.map((c, i) => `
Position ${i + 1}: ${c.position} (${c.positionMeaning})
Card: ${c.card}${c.reversed ? ' (Reversed)' : ''}
Meaning: ${c.meaning}
Keywords: ${c.keywords.join(', ')}
`).join('\n')}
${pastReadingsContext}

Provide your interpretation in the following structured format:

**Key Themes:** [1-2 sentence summary of the main themes and energy]

**Card Analysis:**
${cardsContext.map((c, i) => `
*Position ${i + 1} - ${c.position}:* [Explain how ${c.card} relates to this position. Rate confidence: Strong/Moderate/Exploratory]`).join('\n')}

**Overall Guidance:**
[A cohesive narrative (2-3 paragraphs) that weaves all the cards together${question ? ' and directly addresses the question' : ''}]

**Practical Steps:**
[2-3 specific, actionable insights or suggestions]

Style: ${toneInstructions[tone]}`;
}

// Generate interpretation (non-streaming)
export async function generateInterpretation(
  spreadTypeId: number,
  deckId: number,
  cardsDrawn: CardInReading[],
  question?: string,
  tone: TonePreference = 'warm'
): Promise<string> {
  const context = await getInterpretationContext(spreadTypeId, deckId, cardsDrawn);
  const prompt = buildPrompt(context, question, tone);

  try {
    const message = await anthropic.messages.create({
      model: 'claude-3-5-sonnet-20241022',
      max_tokens: 2048,
      messages: [
        {
          role: 'user',
          content: prompt,
        },
      ],
    });

    return message.content[0].type === 'text' ? message.content[0].text : '';
  } catch (error: any) {
    // Handle Anthropic API errors
    if (error.status === 429 || error.status === 402 || error.message?.includes('credit') || error.message?.includes('quota')) {
      throw new Error('AI_CREDITS_EXHAUSTED');
    }
    throw error;
  }
}

// Generate streaming interpretation
export async function* generateStreamingInterpretation(
  spreadTypeId: number,
  deckId: number,
  cardsDrawn: CardInReading[],
  question?: string,
  tone: TonePreference = 'warm'
): AsyncGenerator<string> {
  const context = await getInterpretationContext(spreadTypeId, deckId, cardsDrawn);
  const prompt = buildPrompt(context, question, tone);

  try {
    const stream = await anthropic.messages.stream({
      model: 'claude-3-5-sonnet-20241022',
      max_tokens: 2048,
      messages: [
        {
          role: 'user',
          content: prompt,
        },
      ],
    });

    for await (const chunk of stream) {
      if (
        chunk.type === 'content_block_delta' &&
        chunk.delta.type === 'text_delta'
      ) {
        yield chunk.delta.text;
      }
    }
  } catch (error: any) {
    // Handle Anthropic API errors
    if (error.status === 429 || error.status === 402 || error.message?.includes('credit') || error.message?.includes('quota')) {
      throw new Error('AI_CREDITS_EXHAUSTED');
    }
    throw error;
  }
}

// Refine user question with AI assistance
export async function refineQuestion(question: string): Promise<string> {
  const prompt = `The user wants to ask this question in a tarot reading: "${question}"

Suggest a more effective way to phrase this question that:
1. Is open-ended rather than yes/no
2. Focuses on "what" or "how" rather than "should I"
3. Empowers the querent to consider multiple perspectives
4. Is specific enough to guide the reading

Respond with ONLY the refined question, nothing else.`;

  try {
    const message = await anthropic.messages.create({
      model: 'claude-3-5-sonnet-20241022',
      max_tokens: 150,
      messages: [
        {
          role: 'user',
          content: prompt,
        },
      ],
    });

    return message.content[0].type === 'text' ? message.content[0].text : question;
  } catch (error: any) {
    // Handle Anthropic API errors
    if (error.status === 429 || error.status === 402 || error.message?.includes('credit') || error.message?.includes('quota')) {
      throw new Error('AI_CREDITS_EXHAUSTED');
    }
    throw error;
  }
}

// Generate follow-up question answer
export async function answerFollowUpQuestion(
  originalInterpretation: string,
  cardsContext: CardContext[],
  spreadName: string,
  followUpQuestion: string
): Promise<string> {
  const prompt = `You previously provided this tarot reading interpretation:

${originalInterpretation}

The reading used the ${spreadName} spread with these cards:
${cardsContext.map((c, i) => `Position ${i + 1}: ${c.card}${c.reversed ? ' (Reversed)' : ''} - ${c.position}`).join('\n')}

The querent now asks: "${followUpQuestion}"

Provide a focused, direct answer to this follow-up question based on the cards and your original interpretation. Keep it to 1-2 paragraphs.`;

  try {
    const message = await anthropic.messages.create({
      model: 'claude-3-5-sonnet-20241022',
      max_tokens: 512,
      messages: [
        {
          role: 'user',
          content: prompt,
        },
      ],
    });

    return message.content[0].type === 'text' ? message.content[0].text : '';
  } catch (error: any) {
    // Handle Anthropic API errors
    if (error.status === 429 || error.status === 402 || error.message?.includes('credit') || error.message?.includes('quota')) {
      throw new Error('AI_CREDITS_EXHAUSTED');
    }
    throw error;
  }
}

// Get specific card explanation in context
export async function explainCardInContext(
  cardContext: CardContext,
  spreadName: string,
  question?: string
): Promise<string> {
  const prompt = `In a ${spreadName} reading${question ? ` about "${question}"` : ''}, explain the significance of:

Card: ${cardContext.card}${cardContext.reversed ? ' (Reversed)' : ''}
Position: ${cardContext.position}
Position Meaning: ${cardContext.positionMeaning}
Card Keywords: ${cardContext.keywords.join(', ')}

Provide a focused explanation (2-3 paragraphs) of what this specific card means in this specific position.`;

  try {
    const message = await anthropic.messages.create({
      model: 'claude-3-5-sonnet-20241022',
      max_tokens: 512,
      messages: [
        {
          role: 'user',
          content: prompt,
        },
      ],
    });

    return message.content[0].type === 'text' ? message.content[0].text : '';
  } catch (error: any) {
    // Handle Anthropic API errors
    if (error.status === 429 || error.status === 402 || error.message?.includes('credit') || error.message?.includes('quota')) {
      throw new Error('AI_CREDITS_EXHAUSTED');
    }
    throw error;
  }
}

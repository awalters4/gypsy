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

export async function generateInterpretation(
  spreadTypeId: number,
  deckId: number,
  cardsDrawn: CardInReading[],
  question?: string
): Promise<string> {
  // Fetch spread type details
  const spreadResult = await pool.query(
    'SELECT * FROM spread_types WHERE id = $1',
    [spreadTypeId]
  );
  const spread = spreadResult.rows[0];

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

  const prompt = `You are an experienced tarot reader. Provide a thoughtful, insightful interpretation for this ${spread.name} reading.

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

Provide a cohesive, narrative interpretation that:
1. Considers the relationship between all cards and their positions
2. Addresses the question if one was asked
3. Offers practical insights and guidance
4. Is warm, thoughtful, and empowering

Keep the interpretation between 3-5 paragraphs.`;

  const message = await anthropic.messages.create({
    model: 'claude-3-5-sonnet-20241022',
    max_tokens: 1024,
    messages: [
      {
        role: 'user',
        content: prompt,
      },
    ],
  });

  return message.content[0].type === 'text' ? message.content[0].text : '';
}

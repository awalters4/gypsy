import { Router, Request, Response } from 'express';
import {
  generateInterpretation,
  generateStreamingInterpretation,
  getInterpretationContext,
  refineQuestion,
  answerFollowUpQuestion,
  explainCardInContext,
  TonePreference,
} from '../services/interpretationService';
import pool from '../database/db';

const router = Router();

// Get AI context preview (what will be sent to AI)
router.post('/context', async (req: Request, res: Response) => {
  const { spreadTypeId, deckId, cardsDrawn } = req.body;

  if (!spreadTypeId || !deckId || !cardsDrawn || cardsDrawn.length === 0) {
    return res.status(400).json({ error: 'Missing required fields' });
  }

  try {
    const context = await getInterpretationContext(spreadTypeId, deckId, cardsDrawn);
    res.json({
      spread: {
        name: context.spread.name,
        description: context.spread.description,
      },
      cards: context.cardsContext,
      pastReadingsCount: context.pastReadingsCount,
    });
  } catch (error: any) {
    console.error('Error fetching context:', error);
    res.status(500).json({ error: error.message || 'Failed to fetch context' });
  }
});

// Refine question with AI
router.post('/refine-question', async (req: Request, res: Response) => {
  const { question } = req.body;

  if (!question || !question.trim()) {
    return res.status(400).json({ error: 'Question is required' });
  }

  try {
    const refinedQuestion = await refineQuestion(question);
    res.json({ original: question, refined: refinedQuestion });
  } catch (error: any) {
    console.error('Error refining question:', error);
    res.status(500).json({ error: error.message || 'Failed to refine question' });
  }
});

// Generate streaming interpretation
router.post('/stream', async (req: Request, res: Response) => {
  const { userId, spreadTypeId, deckId, question, cardsDrawn, tone } = req.body;

  if (!spreadTypeId || !deckId || !cardsDrawn || cardsDrawn.length === 0) {
    return res.status(400).json({ error: 'Missing required fields' });
  }

  try {
    // Set headers for Server-Sent Events
    res.setHeader('Content-Type', 'text/event-stream');
    res.setHeader('Cache-Control', 'no-cache');
    res.setHeader('Connection', 'keep-alive');

    let fullInterpretation = '';

    // Stream the interpretation
    const generator = generateStreamingInterpretation(
      spreadTypeId,
      deckId,
      cardsDrawn,
      question,
      tone as TonePreference
    );

    for await (const chunk of generator) {
      fullInterpretation += chunk;
      res.write(`data: ${JSON.stringify({ chunk })}\n\n`);
    }

    // Save the reading to the database
    const result = await pool.query(
      `INSERT INTO readings (user_id, spread_type_id, deck_id, question, cards_drawn, interpretation)
       VALUES ($1, $2, $3, $4, $5, $6)
       RETURNING id`,
      [userId || null, spreadTypeId, deckId, question || null, JSON.stringify(cardsDrawn), fullInterpretation]
    );

    // Send completion event with reading ID
    res.write(`data: ${JSON.stringify({ done: true, readingId: result.rows[0].id })}\n\n`);
    res.end();
  } catch (error: any) {
    console.error('Error generating streaming interpretation:', error);
    res.write(`data: ${JSON.stringify({ error: error.message || 'Failed to generate interpretation' })}\n\n`);
    res.end();
  }
});

// Generate interpretation (non-streaming, backward compatible)
router.post('/', async (req: Request, res: Response) => {
  const { userId, spreadTypeId, deckId, question, cardsDrawn, tone } = req.body;

  if (!spreadTypeId || !deckId || !cardsDrawn || cardsDrawn.length === 0) {
    return res.status(400).json({ error: 'Missing required fields' });
  }

  try {
    // Generate interpretation using AI
    const interpretation = await generateInterpretation(
      spreadTypeId,
      deckId,
      cardsDrawn,
      question,
      tone as TonePreference
    );

    // Save the reading to the database
    const result = await pool.query(
      `INSERT INTO readings (user_id, spread_type_id, deck_id, question, cards_drawn, interpretation)
       VALUES ($1, $2, $3, $4, $5, $6)
       RETURNING *`,
      [userId || null, spreadTypeId, deckId, question || null, JSON.stringify(cardsDrawn), interpretation]
    );

    res.json({
      reading: result.rows[0],
      interpretation,
    });
  } catch (error: any) {
    console.error('Error generating interpretation:', error);
    res.status(500).json({ error: error.message || 'Failed to generate interpretation' });
  }
});

// Answer follow-up question about a reading
router.post('/follow-up', async (req: Request, res: Response) => {
  const { readingId, followUpQuestion } = req.body;

  if (!readingId || !followUpQuestion || !followUpQuestion.trim()) {
    return res.status(400).json({ error: 'Reading ID and follow-up question are required' });
  }

  try {
    // Fetch the original reading
    const readingResult = await pool.query(
      `SELECT r.*, st.name as spread_name
       FROM readings r
       JOIN spread_types st ON r.spread_type_id = st.id
       WHERE r.id = $1`,
      [readingId]
    );

    if (readingResult.rows.length === 0) {
      return res.status(404).json({ error: 'Reading not found' });
    }

    const reading = readingResult.rows[0];

    // Get context for the cards
    const context = await getInterpretationContext(
      reading.spread_type_id,
      reading.deck_id,
      reading.cards_drawn
    );

    // Generate answer
    const answer = await answerFollowUpQuestion(
      reading.interpretation,
      context.cardsContext,
      reading.spread_name,
      followUpQuestion
    );

    res.json({ answer });
  } catch (error: any) {
    console.error('Error answering follow-up:', error);
    res.status(500).json({ error: error.message || 'Failed to answer follow-up question' });
  }
});

// Explain specific card in context
router.post('/explain-card', async (req: Request, res: Response) => {
  const { readingId, cardPosition } = req.body;

  if (!readingId || cardPosition === undefined) {
    return res.status(400).json({ error: 'Reading ID and card position are required' });
  }

  try {
    // Fetch the reading
    const readingResult = await pool.query(
      `SELECT r.*, st.name as spread_name
       FROM readings r
       JOIN spread_types st ON r.spread_type_id = st.id
       WHERE r.id = $1`,
      [readingId]
    );

    if (readingResult.rows.length === 0) {
      return res.status(404).json({ error: 'Reading not found' });
    }

    const reading = readingResult.rows[0];

    // Get context for the cards
    const context = await getInterpretationContext(
      reading.spread_type_id,
      reading.deck_id,
      reading.cards_drawn
    );

    // Find the specific card
    const cardContext = context.cardsContext.find((c, idx) => idx + 1 === cardPosition);

    if (!cardContext) {
      return res.status(404).json({ error: 'Card not found at this position' });
    }

    // Generate explanation
    const explanation = await explainCardInContext(
      cardContext,
      reading.spread_name,
      reading.question
    );

    res.json({ explanation, card: cardContext });
  } catch (error: any) {
    console.error('Error explaining card:', error);
    res.status(500).json({ error: error.message || 'Failed to explain card' });
  }
});

export default router;

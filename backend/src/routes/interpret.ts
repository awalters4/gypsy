import { Router, Request, Response } from 'express';
import { generateInterpretation } from '../services/interpretationService';
import pool from '../database/db';

const router = Router();

// Generate interpretation for a reading
router.post('/', async (req: Request, res: Response) => {
  const { userId, spreadTypeId, deckId, question, cardsDrawn } = req.body;

  if (!spreadTypeId || !deckId || !cardsDrawn || cardsDrawn.length === 0) {
    return res.status(400).json({ error: 'Missing required fields' });
  }

  try {
    // Generate interpretation using AI
    const interpretation = await generateInterpretation(
      spreadTypeId,
      deckId,
      cardsDrawn,
      question
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
  } catch (error) {
    console.error('Error generating interpretation:', error);
    res.status(500).json({ error: 'Failed to generate interpretation' });
  }
});

export default router;

import { Router, Request, Response } from 'express';
import pool from '../database/db';

const router = Router();

// Get all readings
router.get('/', async (req: Request, res: Response) => {
  try {
    const result = await pool.query(
      'SELECT * FROM readings ORDER BY created_at DESC'
    );
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching readings:', error);
    res.status(500).json({ error: 'Failed to fetch readings' });
  }
});

// Create a new reading
router.post('/', async (req: Request, res: Response) => {
  const { userId, spreadTypeId, deckId, question, cardsDrawn, interpretation } = req.body;

  try {
    const result = await pool.query(
      `INSERT INTO readings (user_id, spread_type_id, deck_id, question, cards_drawn, interpretation)
       VALUES ($1, $2, $3, $4, $5, $6)
       RETURNING *`,
      [userId, spreadTypeId, deckId, question, JSON.stringify(cardsDrawn), interpretation]
    );
    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error('Error creating reading:', error);
    res.status(500).json({ error: 'Failed to create reading' });
  }
});

// Get a specific reading
router.get('/:id', async (req: Request, res: Response) => {
  const { id } = req.params;

  try {
    const result = await pool.query('SELECT * FROM readings WHERE id = $1', [id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Reading not found' });
    }
    res.json(result.rows[0]);
  } catch (error) {
    console.error('Error fetching reading:', error);
    res.status(500).json({ error: 'Failed to fetch reading' });
  }
});

// Submit feedback for a reading
router.post('/:id/feedback', async (req: Request, res: Response) => {
  const { id } = req.params;
  const { accuracyRating, resonanceRating, notes } = req.body;

  try {
    const result = await pool.query(
      `INSERT INTO reading_feedback (reading_id, accuracy_rating, resonance_rating, notes)
       VALUES ($1, $2, $3, $4)
       RETURNING *`,
      [id, accuracyRating, resonanceRating, notes]
    );
    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error('Error submitting feedback:', error);
    res.status(500).json({ error: 'Failed to submit feedback' });
  }
});

export default router;

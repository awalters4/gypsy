import { Router, Request, Response } from 'express';
import pool from '../database/db';

const router = Router();

// Get all decks
router.get('/', async (req: Request, res: Response) => {
  try {
    const result = await pool.query('SELECT * FROM decks ORDER BY name');
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching decks:', error);
    res.status(500).json({ error: 'Failed to fetch decks' });
  }
});

// Get a specific deck
router.get('/:id', async (req: Request, res: Response) => {
  const { id } = req.params;

  try {
    const result = await pool.query('SELECT * FROM decks WHERE id = $1', [id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Deck not found' });
    }
    res.json(result.rows[0]);
  } catch (error) {
    console.error('Error fetching deck:', error);
    res.status(500).json({ error: 'Failed to fetch deck' });
  }
});

export default router;

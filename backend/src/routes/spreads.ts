import { Router, Request, Response } from 'express';
import pool from '../database/db';

const router = Router();

// Get all spread types
router.get('/', async (req: Request, res: Response) => {
  try {
    const result = await pool.query('SELECT * FROM spread_types ORDER BY name');
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching spread types:', error);
    res.status(500).json({ error: 'Failed to fetch spread types' });
  }
});

// Get a specific spread type
router.get('/:id', async (req: Request, res: Response) => {
  const { id } = req.params;

  try {
    const result = await pool.query('SELECT * FROM spread_types WHERE id = $1', [id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Spread type not found' });
    }
    res.json(result.rows[0]);
  } catch (error) {
    console.error('Error fetching spread type:', error);
    res.status(500).json({ error: 'Failed to fetch spread type' });
  }
});

export default router;

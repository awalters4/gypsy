import { Router, Request, Response } from 'express';
import pool from '../database/db';

const router = Router();

// Get all cards with meanings for a specific deck
router.get('/', async (req: Request, res: Response) => {
  const { deckId } = req.query;

  try {
    let query = `
      SELECT
        c.id, c.name, c.number, c.suit, c.card_type, c.archetype,
        cm.upright_meaning, cm.reversed_meaning,
        cm.upright_keywords, cm.reversed_keywords,
        ci.image_url, ci.reversed_image_url
      FROM cards c
      LEFT JOIN card_meanings cm ON c.id = cm.card_id
      LEFT JOIN card_images ci ON c.id = ci.card_id AND ci.deck_id = cm.deck_id
    `;

    const params = [];
    if (deckId) {
      query += ' WHERE cm.deck_id = $1';
      params.push(deckId);
    }

    query += ' ORDER BY c.card_type, c.suit, c.number';

    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching cards:', error);
    res.status(500).json({ error: 'Failed to fetch cards' });
  }
});

// Get a specific card
router.get('/:id', async (req: Request, res: Response) => {
  const { id } = req.params;
  const { deckId } = req.query;

  try {
    const result = await pool.query(
      `SELECT
        c.id, c.name, c.number, c.suit, c.card_type, c.archetype,
        cm.upright_meaning, cm.reversed_meaning,
        cm.upright_keywords, cm.reversed_keywords,
        ci.image_url, ci.reversed_image_url
      FROM cards c
      LEFT JOIN card_meanings cm ON c.id = cm.card_id
      LEFT JOIN card_images ci ON c.id = ci.card_id AND ci.deck_id = cm.deck_id
      WHERE c.id = $1 AND (cm.deck_id = $2 OR $2 IS NULL)`,
      [id, deckId || null]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Card not found' });
    }

    res.json(result.rows[0]);
  } catch (error) {
    console.error('Error fetching card:', error);
    res.status(500).json({ error: 'Failed to fetch card' });
  }
});

export default router;

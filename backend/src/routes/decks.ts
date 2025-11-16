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

// Create a new deck
router.post('/', async (req: Request, res: Response) => {
  const { name, description, imagery_style } = req.body;

  if (!name) {
    return res.status(400).json({ error: 'Deck name is required' });
  }

  try {
    const result = await pool.query(
      `INSERT INTO decks (name, description, imagery_style)
       VALUES ($1, $2, $3)
       RETURNING *`,
      [name, description || null, imagery_style || null]
    );
    res.status(201).json(result.rows[0]);
  } catch (error: any) {
    console.error('Error creating deck:', error);
    if (error.code === '23505') { // Unique violation
      return res.status(409).json({ error: 'A deck with this name already exists' });
    }
    res.status(500).json({ error: 'Failed to create deck' });
  }
});

// Update a deck
router.put('/:id', async (req: Request, res: Response) => {
  const { id } = req.params;
  const { name, description, imagery_style } = req.body;

  if (!name) {
    return res.status(400).json({ error: 'Deck name is required' });
  }

  try {
    const result = await pool.query(
      `UPDATE decks
       SET name = $1, description = $2, imagery_style = $3
       WHERE id = $4
       RETURNING *`,
      [name, description || null, imagery_style || null, id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Deck not found' });
    }

    res.json(result.rows[0]);
  } catch (error: any) {
    console.error('Error updating deck:', error);
    if (error.code === '23505') {
      return res.status(409).json({ error: 'A deck with this name already exists' });
    }
    res.status(500).json({ error: 'Failed to update deck' });
  }
});

// Delete a deck
router.delete('/:id', async (req: Request, res: Response) => {
  const { id } = req.params;

  try {
    const result = await pool.query('DELETE FROM decks WHERE id = $1 RETURNING *', [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Deck not found' });
    }

    res.json({ message: 'Deck deleted successfully', deck: result.rows[0] });
  } catch (error) {
    console.error('Error deleting deck:', error);
    res.status(500).json({ error: 'Failed to delete deck' });
  }
});

// Get card meanings for a specific deck
router.get('/:id/card-meanings', async (req: Request, res: Response) => {
  const { id } = req.params;

  try {
    // First check if deck exists
    const deckCheck = await pool.query('SELECT id FROM decks WHERE id = $1', [id]);
    if (deckCheck.rows.length === 0) {
      return res.status(404).json({ error: 'Deck not found' });
    }

    const result = await pool.query(
      `SELECT cm.*, c.name as card_name, c.suit, c.number, c.card_type
       FROM card_meanings cm
       JOIN cards c ON cm.card_id = c.id
       WHERE cm.deck_id = $1
       ORDER BY c.card_type, c.number`,
      [id]
    );

    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching card meanings:', error);
    res.status(500).json({ error: 'Failed to fetch card meanings' });
  }
});

// Bulk upload card meanings for a deck
router.post('/:id/card-meanings/bulk', async (req: Request, res: Response) => {
  const { id } = req.params;
  const { cardMeanings } = req.body;

  if (!Array.isArray(cardMeanings) || cardMeanings.length === 0) {
    return res.status(400).json({ error: 'cardMeanings array is required' });
  }

  try {
    // Check if deck exists
    const deckCheck = await pool.query('SELECT id FROM decks WHERE id = $1', [id]);
    if (deckCheck.rows.length === 0) {
      return res.status(404).json({ error: 'Deck not found' });
    }

    // Start transaction
    await pool.query('BEGIN');

    const inserted = [];
    for (const meaning of cardMeanings) {
      const { cardId, uprightMeaning, reversedMeaning, uprightKeywords, reversedKeywords } = meaning;

      if (!cardId || !uprightMeaning) {
        await pool.query('ROLLBACK');
        return res.status(400).json({
          error: 'Each card meaning must have cardId and uprightMeaning'
        });
      }

      const result = await pool.query(
        `INSERT INTO card_meanings
         (card_id, deck_id, upright_meaning, reversed_meaning, upright_keywords, reversed_keywords)
         VALUES ($1, $2, $3, $4, $5, $6)
         ON CONFLICT (card_id, deck_id)
         DO UPDATE SET
           upright_meaning = EXCLUDED.upright_meaning,
           reversed_meaning = EXCLUDED.reversed_meaning,
           upright_keywords = EXCLUDED.upright_keywords,
           reversed_keywords = EXCLUDED.reversed_keywords
         RETURNING *`,
        [
          cardId,
          id,
          uprightMeaning,
          reversedMeaning || null,
          uprightKeywords || [],
          reversedKeywords || []
        ]
      );

      inserted.push(result.rows[0]);
    }

    await pool.query('COMMIT');

    res.status(201).json({
      message: `Successfully uploaded ${inserted.length} card meanings`,
      cardMeanings: inserted
    });
  } catch (error: any) {
    await pool.query('ROLLBACK');
    console.error('Error uploading card meanings:', error);
    res.status(500).json({ error: error.message || 'Failed to upload card meanings' });
  }
});

// Update a single card meaning
router.put('/:deckId/card-meanings/:cardId', async (req: Request, res: Response) => {
  const { deckId, cardId } = req.params;
  const { uprightMeaning, reversedMeaning, uprightKeywords, reversedKeywords } = req.body;

  if (!uprightMeaning) {
    return res.status(400).json({ error: 'uprightMeaning is required' });
  }

  try {
    const result = await pool.query(
      `UPDATE card_meanings
       SET upright_meaning = $1,
           reversed_meaning = $2,
           upright_keywords = $3,
           reversed_keywords = $4
       WHERE deck_id = $5 AND card_id = $6
       RETURNING *`,
      [
        uprightMeaning,
        reversedMeaning || null,
        uprightKeywords || [],
        reversedKeywords || [],
        deckId,
        cardId
      ]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Card meaning not found for this deck' });
    }

    res.json(result.rows[0]);
  } catch (error) {
    console.error('Error updating card meaning:', error);
    res.status(500).json({ error: 'Failed to update card meaning' });
  }
});

// Delete a single card meaning
router.delete('/:deckId/card-meanings/:cardId', async (req: Request, res: Response) => {
  const { deckId, cardId } = req.params;

  try {
    const result = await pool.query(
      'DELETE FROM card_meanings WHERE deck_id = $1 AND card_id = $2 RETURNING *',
      [deckId, cardId]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Card meaning not found for this deck' });
    }

    res.json({ message: 'Card meaning deleted successfully' });
  } catch (error) {
    console.error('Error deleting card meaning:', error);
    res.status(500).json({ error: 'Failed to delete card meaning' });
  }
});

export default router;

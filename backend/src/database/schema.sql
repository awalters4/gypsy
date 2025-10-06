-- Tarot Reader Database Schema

-- Decks table
CREATE TABLE decks (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  imagery_style VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Cards table (general card info, deck-agnostic)
CREATE TABLE cards (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  number INTEGER,
  suit VARCHAR(50), -- cups, pentacles, swords, wands, major
  card_type VARCHAR(50), -- major_arcana, minor_arcana
  archetype VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Card meanings (deck-specific meanings)
CREATE TABLE card_meanings (
  id SERIAL PRIMARY KEY,
  card_id INTEGER REFERENCES cards(id) ON DELETE CASCADE,
  deck_id INTEGER REFERENCES decks(id) ON DELETE CASCADE,
  upright_meaning TEXT NOT NULL,
  reversed_meaning TEXT,
  upright_keywords TEXT[], -- array of keywords
  reversed_keywords TEXT[],
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(card_id, deck_id)
);

-- Spread types
CREATE TABLE spread_types (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  description TEXT,
  position_count INTEGER NOT NULL,
  positions JSONB NOT NULL, -- [{position: 1, name: "Past", meaning: "..."}]
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Users (optional - for tracking individual user readings)
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(255) UNIQUE,
  email VARCHAR(255) UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Readings
CREATE TABLE readings (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
  spread_type_id INTEGER REFERENCES spread_types(id) ON DELETE SET NULL,
  deck_id INTEGER REFERENCES decks(id) ON DELETE SET NULL,
  question TEXT,
  cards_drawn JSONB NOT NULL, -- [{card_id: 1, position: 1, reversed: false}]
  interpretation TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Reading feedback (for learning/improvement)
CREATE TABLE reading_feedback (
  id SERIAL PRIMARY KEY,
  reading_id INTEGER REFERENCES readings(id) ON DELETE CASCADE,
  accuracy_rating INTEGER CHECK (accuracy_rating >= 1 AND accuracy_rating <= 5),
  resonance_rating INTEGER CHECK (resonance_rating >= 1 AND resonance_rating <= 5),
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Card images
CREATE TABLE card_images (
  id SERIAL PRIMARY KEY,
  card_id INTEGER REFERENCES cards(id) ON DELETE CASCADE,
  deck_id INTEGER REFERENCES decks(id) ON DELETE CASCADE,
  image_url TEXT NOT NULL,
  reversed_image_url TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(card_id, deck_id)
);

-- Indexes for performance
CREATE INDEX idx_card_meanings_card_id ON card_meanings(card_id);
CREATE INDEX idx_card_meanings_deck_id ON card_meanings(deck_id);
CREATE INDEX idx_readings_user_id ON readings(user_id);
CREATE INDEX idx_readings_created_at ON readings(created_at);
CREATE INDEX idx_reading_feedback_reading_id ON reading_feedback(reading_id);

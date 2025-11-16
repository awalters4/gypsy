-- ============================================
-- GYPSY TAROT READER - COMPLETE DATABASE SETUP
-- ============================================
-- Run this file on Neon or any PostgreSQL database
-- This combines schema + all seed data
-- ============================================

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

-- ============================================
-- 001_initial_seed.sql
-- ============================================

-- Insert Rider-Waite deck
INSERT INTO decks (name, description, imagery_style) VALUES
('Rider-Waite', 'The most popular and influential tarot deck, created by A.E. Waite and illustrated by Pamela Colman Smith in 1909.', 'Traditional');

-- Insert Major Arcana cards
INSERT INTO cards (name, number, suit, card_type, archetype) VALUES
('The Fool', 0, 'major', 'major_arcana', 'New beginnings, innocence, adventure'),
('The Magician', 1, 'major', 'major_arcana', 'Manifestation, resourcefulness, power'),
('The High Priestess', 2, 'major', 'major_arcana', 'Intuition, sacred knowledge, subconscious'),
('The Empress', 3, 'major', 'major_arcana', 'Femininity, beauty, nature, abundance'),
('The Emperor', 4, 'major', 'major_arcana', 'Authority, structure, control, father figure'),
('The Hierophant', 5, 'major', 'major_arcana', 'Spiritual wisdom, tradition, conformity'),
('The Lovers', 6, 'major', 'major_arcana', 'Love, harmony, relationships, choices'),
('The Chariot', 7, 'major', 'major_arcana', 'Control, willpower, victory, determination'),
('Strength', 8, 'major', 'major_arcana', 'Courage, bravery, confidence, inner strength'),
('The Hermit', 9, 'major', 'major_arcana', 'Soul-searching, introspection, inner guidance'),
('Wheel of Fortune', 10, 'major', 'major_arcana', 'Change, cycles, fate, turning point'),
('Justice', 11, 'major', 'major_arcana', 'Justice, fairness, truth, law'),
('The Hanged Man', 12, 'major', 'major_arcana', 'Suspension, restriction, letting go, sacrifice'),
('Death', 13, 'major', 'major_arcana', 'Endings, change, transformation, transition'),
('Temperance', 14, 'major', 'major_arcana', 'Balance, moderation, patience, purpose'),
('The Devil', 15, 'major', 'major_arcana', 'Bondage, addiction, materialism, playfulness'),
('The Tower', 16, 'major', 'major_arcana', 'Sudden change, upheaval, revelation, awakening'),
('The Star', 17, 'major', 'major_arcana', 'Hope, faith, rejuvenation, spirituality'),
('The Moon', 18, 'major', 'major_arcana', 'Illusion, fear, anxiety, subconscious'),
('The Sun', 19, 'major', 'major_arcana', 'Positivity, fun, warmth, success, vitality'),
('Judgement', 20, 'major', 'major_arcana', 'Reflection, reckoning, inner calling, absolution'),
('The World', 21, 'major', 'major_arcana', 'Completion, accomplishment, travel, fulfillment');

-- Insert Wands cards
INSERT INTO cards (name, number, suit, card_type, archetype) VALUES
('Ace of Wands', 1, 'wands', 'minor_arcana', 'Inspiration, new opportunities, growth'),
('Two of Wands', 2, 'wands', 'minor_arcana', 'Planning, making decisions, leaving comfort zone'),
('Three of Wands', 3, 'wands', 'minor_arcana', 'Expansion, foresight, overseas opportunities'),
('Four of Wands', 4, 'wands', 'minor_arcana', 'Celebration, harmony, marriage, home'),
('Five of Wands', 5, 'wands', 'minor_arcana', 'Conflict, competition, tension'),
('Six of Wands', 6, 'wands', 'minor_arcana', 'Victory, success, public recognition'),
('Seven of Wands', 7, 'wands', 'minor_arcana', 'Challenge, competition, perseverance'),
('Eight of Wands', 8, 'wands', 'minor_arcana', 'Speed, action, air travel, movement'),
('Nine of Wands', 9, 'wands', 'minor_arcana', 'Resilience, courage, persistence'),
('Ten of Wands', 10, 'wands', 'minor_arcana', 'Burden, responsibility, hard work'),
('Page of Wands', 11, 'wands', 'minor_arcana', 'Exploration, excitement, freedom'),
('Knight of Wands', 12, 'wands', 'minor_arcana', 'Energy, passion, adventure, impulsiveness'),
('Queen of Wands', 13, 'wands', 'minor_arcana', 'Courage, confidence, independence, determination'),
('King of Wands', 14, 'wands', 'minor_arcana', 'Natural leader, vision, entrepreneur');

-- Insert Cups cards
INSERT INTO cards (name, number, suit, card_type, archetype) VALUES
('Ace of Cups', 1, 'cups', 'minor_arcana', 'Love, new relationships, compassion'),
('Two of Cups', 2, 'cups', 'minor_arcana', 'Unified love, partnership, mutual attraction'),
('Three of Cups', 3, 'cups', 'minor_arcana', 'Celebration, friendship, creativity'),
('Four of Cups', 4, 'cups', 'minor_arcana', 'Apathy, contemplation, disconnectedness'),
('Five of Cups', 5, 'cups', 'minor_arcana', 'Regret, failure, disappointment, loss'),
('Six of Cups', 6, 'cups', 'minor_arcana', 'Nostalgia, childhood memories, innocence'),
('Seven of Cups', 7, 'cups', 'minor_arcana', 'Choices, fantasy, illusion, wishful thinking'),
('Eight of Cups', 8, 'cups', 'minor_arcana', 'Disappointment, abandonment, withdrawal'),
('Nine of Cups', 9, 'cups', 'minor_arcana', 'Contentment, satisfaction, wishes come true'),
('Ten of Cups', 10, 'cups', 'minor_arcana', 'Harmony, happiness, alignment, family'),
('Page of Cups', 11, 'cups', 'minor_arcana', 'Creative opportunities, intuition, curiosity'),
('Knight of Cups', 12, 'cups', 'minor_arcana', 'Romance, charm, imagination, beauty'),
('Queen of Cups', 13, 'cups', 'minor_arcana', 'Compassion, calm, comfort, emotional stability'),
('King of Cups', 14, 'cups', 'minor_arcana', 'Emotional balance, control, generosity');

-- Insert Swords cards
INSERT INTO cards (name, number, suit, card_type, archetype) VALUES
('Ace of Swords', 1, 'swords', 'minor_arcana', 'Breakthrough, clarity, sharp mind'),
('Two of Swords', 2, 'swords', 'minor_arcana', 'Difficult decisions, stalemate, avoidance'),
('Three of Swords', 3, 'swords', 'minor_arcana', 'Heartbreak, sorrow, grief, suffering'),
('Four of Swords', 4, 'swords', 'minor_arcana', 'Rest, relaxation, meditation, contemplation'),
('Five of Swords', 5, 'swords', 'minor_arcana', 'Conflict, defeat, winning at all costs'),
('Six of Swords', 6, 'swords', 'minor_arcana', 'Transition, change, rite of passage'),
('Seven of Swords', 7, 'swords', 'minor_arcana', 'Betrayal, deception, getting away with something'),
('Eight of Swords', 8, 'swords', 'minor_arcana', 'Restriction, imprisonment, victim mentality'),
('Nine of Swords', 9, 'swords', 'minor_arcana', 'Anxiety, worry, fear, depression'),
('Ten of Swords', 10, 'swords', 'minor_arcana', 'Painful endings, deep wounds, betrayal'),
('Page of Swords', 11, 'swords', 'minor_arcana', 'Curiosity, restlessness, mental energy'),
('Knight of Swords', 12, 'swords', 'minor_arcana', 'Ambitious, action-oriented, driven to succeed'),
('Queen of Swords', 13, 'swords', 'minor_arcana', 'Independent, clear thinking, direct communication'),
('King of Swords', 14, 'swords', 'minor_arcana', 'Intellectual power, authority, truth');

-- Insert Pentacles cards
INSERT INTO cards (name, number, suit, card_type, archetype) VALUES
('Ace of Pentacles', 1, 'pentacles', 'minor_arcana', 'Manifestation, new opportunity, prosperity'),
('Two of Pentacles', 2, 'pentacles', 'minor_arcana', 'Balance, adaptability, time management'),
('Three of Pentacles', 3, 'pentacles', 'minor_arcana', 'Teamwork, collaboration, learning'),
('Four of Pentacles', 4, 'pentacles', 'minor_arcana', 'Saving money, security, conservatism'),
('Five of Pentacles', 5, 'pentacles', 'minor_arcana', 'Financial loss, poverty, insecurity'),
('Six of Pentacles', 6, 'pentacles', 'minor_arcana', 'Generosity, charity, sharing wealth'),
('Seven of Pentacles', 7, 'pentacles', 'minor_arcana', 'Long-term view, sustainable results, patience'),
('Eight of Pentacles', 8, 'pentacles', 'minor_arcana', 'Apprenticeship, skill development, dedication'),
('Nine of Pentacles', 9, 'pentacles', 'minor_arcana', 'Abundance, luxury, self-sufficiency'),
('Ten of Pentacles', 10, 'pentacles', 'minor_arcana', 'Wealth, inheritance, family, legacy'),
('Page of Pentacles', 11, 'pentacles', 'minor_arcana', 'Manifestation, financial opportunity, skill development'),
('Knight of Pentacles', 12, 'pentacles', 'minor_arcana', 'Hard work, productivity, routine, conservatism'),
('Queen of Pentacles', 13, 'pentacles', 'minor_arcana', 'Practical, nurturing, providing, down-to-earth'),
('King of Pentacles', 14, 'pentacles', 'minor_arcana', 'Wealth, business, leadership, security');

-- ============================================
-- 002_card_meanings.sql
-- ============================================

-- Card meanings for Rider-Waite deck (deck_id = 1)
-- Major Arcana meanings

INSERT INTO card_meanings (card_id, deck_id, upright_meaning, reversed_meaning, upright_keywords, reversed_keywords) VALUES
(1, 1, 'The Fool represents new beginnings, having faith in the future, being inexperienced, not knowing what to expect, having beginner''s luck, improvisation and believing in the universe.', 'The reversed Fool suggests holding back, recklessness, risk-taking, and behaving foolishly.', ARRAY['beginnings', 'innocence', 'spontaneity', 'free spirit'], ARRAY['recklessness', 'taken advantage of', 'inconsideration', 'naivety']),

(2, 1, 'The Magician is about manifestation, having the power to manifest your desires, being resourceful, inspired action, and being able to turn your dreams into reality.', 'The reversed Magician can indicate manipulation, poor planning, untapped talents, and trickery.', ARRAY['manifestation', 'resourcefulness', 'power', 'inspired action'], ARRAY['manipulation', 'poor planning', 'untapped talents', 'illusions']),

(3, 1, 'The High Priestess represents intuition, accessing the subconscious mind, divine feminine energy, sacred knowledge, and things yet to be revealed.', 'Reversed, she suggests secrets, disconnected from intuition, withdrawal and silence, and repressed feelings.', ARRAY['intuition', 'sacred knowledge', 'divine feminine', 'subconscious'], ARRAY['secrets', 'disconnected', 'silence', 'repressed feelings']),

(4, 1, 'The Empress signifies femininity, beauty, nature, nurturing, and abundance. She is a mother figure who provides and cares.', 'Reversed, The Empress can mean creative block, dependence on others, smothering, and emptiness.', ARRAY['femininity', 'beauty', 'nature', 'abundance', 'nurturing'], ARRAY['creative block', 'dependence', 'smothering', 'emptiness']),

(5, 1, 'The Emperor represents authority, father figure, structure, solid foundation, and establishing power and control.', 'Reversed, he indicates domination, excessive control, rigidity, and lack of discipline.', ARRAY['authority', 'establishment', 'structure', 'father figure'], ARRAY['domination', 'excessive control', 'lack of discipline', 'inflexibility']),

(6, 1, 'The Hierophant represents spiritual wisdom, religious beliefs, conformity, tradition, and institutions.', 'Reversed, it suggests personal beliefs, freedom, challenging the status quo, and rebellion.', ARRAY['spiritual wisdom', 'tradition', 'conformity', 'institutions'], ARRAY['personal beliefs', 'freedom', 'challenging norms', 'unconventional']),

(7, 1, 'The Lovers represent love, harmony, relationships, values alignment, and making choices from the heart.', 'Reversed, The Lovers indicate self-love, disharmony, imbalance, and misalignment of values.', ARRAY['love', 'harmony', 'relationships', 'choices'], ARRAY['self-love', 'disharmony', 'imbalance', 'misalignment']),

(8, 1, 'The Chariot is about control, willpower, success, action, and determination to overcome obstacles.', 'Reversed, it suggests self-discipline issues, opposition, lack of direction, and aggression.', ARRAY['control', 'willpower', 'success', 'determination'], ARRAY['self-discipline', 'opposition', 'lack of direction', 'aggression']),

(9, 1, 'Strength represents strength, courage, persuasion, influence, and compassion. It''s about inner strength and fortitude.', 'Reversed, Strength can mean self-doubt, weakness, insecurity, and low confidence.', ARRAY['strength', 'courage', 'persuasion', 'compassion'], ARRAY['self-doubt', 'weakness', 'insecurity', 'low confidence']),

(10, 1, 'The Hermit represents soul-searching, introspection, being alone, inner guidance, and seeking truth.', 'Reversed, he suggests isolation, loneliness, withdrawal, and being lost.', ARRAY['soul-searching', 'introspection', 'inner guidance', 'solitude'], ARRAY['isolation', 'loneliness', 'withdrawal', 'lost']),

(11, 1, 'The Wheel of Fortune is about good luck, karma, life cycles, destiny, and a turning point in your life.', 'Reversed, it indicates bad luck, resistance to change, breaking cycles, and lack of control.', ARRAY['good luck', 'karma', 'life cycles', 'destiny', 'turning point'], ARRAY['bad luck', 'resistance', 'breaking cycles', 'lack of control']),

(12, 1, 'Justice represents justice, fairness, truth, cause and effect, and law. What you give, you receive.', 'Reversed, Justice indicates unfairness, lack of accountability, dishonesty, and injustice.', ARRAY['justice', 'fairness', 'truth', 'cause and effect', 'law'], ARRAY['unfairness', 'lack of accountability', 'dishonesty', 'injustice']),

(13, 1, 'The Hanged Man is about suspension, letting go, sacrifice, and gaining new perspectives through patience.', 'Reversed, he suggests delays, resistance, stalling, and indecision.', ARRAY['suspension', 'letting go', 'new perspective', 'patience'], ARRAY['delays', 'resistance', 'stalling', 'indecision']),

(14, 1, 'Death represents endings, change, transformation, and transition. It rarely means physical death, but rather symbolic endings.', 'Reversed, Death suggests resistance to change, personal transformation, inner purging, and fear of change.', ARRAY['endings', 'change', 'transformation', 'transition'], ARRAY['resistance to change', 'fear', 'stagnation', 'decay']),

(15, 1, 'Temperance represents balance, moderation, patience, purpose, and finding meaning in life.', 'Reversed, it indicates imbalance, excess, self-healing, and re-alignment.', ARRAY['balance', 'moderation', 'patience', 'purpose'], ARRAY['imbalance', 'excess', 'self-healing', 're-alignment']),

(16, 1, 'The Devil represents attachment, addiction, restriction, sexuality, and feeling trapped by material desires.', 'Reversed, The Devil suggests releasing limiting beliefs, exploring dark thoughts, detachment, and breaking free.', ARRAY['attachment', 'addiction', 'restriction', 'materialism'], ARRAY['releasing', 'detachment', 'breaking free', 'independence']),

(17, 1, 'The Tower represents sudden change, upheaval, chaos, revelation, and awakening. It can be a shocking event.', 'Reversed, The Tower indicates personal transformation, fear of change, averting disaster, and delayed disaster.', ARRAY['sudden change', 'upheaval', 'chaos', 'revelation'], ARRAY['personal transformation', 'fear of change', 'averting disaster', 'delayed crisis']),

(18, 1, 'The Star represents hope, faith, purpose, renewal, and spirituality. It''s a beacon of light and inspiration.', 'Reversed, The Star suggests lack of faith, despair, self-trust issues, and disconnection.', ARRAY['hope', 'faith', 'purpose', 'renewal', 'spirituality'], ARRAY['lack of faith', 'despair', 'disconnection', 'insecurity']),

(19, 1, 'The Moon represents illusion, fear, anxiety, subconscious, and intuition. Things may not be as they seem.', 'Reversed, The Moon indicates releasing fear, repressed emotion, inner confusion, and unveiling secrets.', ARRAY['illusion', 'fear', 'anxiety', 'subconscious', 'intuition'], ARRAY['releasing fear', 'repressed emotion', 'clarity', 'truth revealed']),

(20, 1, 'The Sun represents positivity, fun, warmth, success, and vitality. It''s a very positive and uplifting card.', 'Reversed, The Sun suggests inner child, feeling down, overly optimistic, and temporary depression.', ARRAY['positivity', 'fun', 'warmth', 'success', 'vitality'], ARRAY['inner child', 'feeling down', 'overly optimistic', 'sadness']),

(21, 1, 'Judgement represents judgement, rebirth, inner calling, absolution, and making important life decisions.', 'Reversed, it indicates self-doubt, inner critic, ignoring the call, and self-loathing.', ARRAY['judgement', 'rebirth', 'inner calling', 'absolution'], ARRAY['self-doubt', 'inner critic', 'ignoring call', 'self-loathing']),

(22, 1, 'The World represents completion, accomplishment, travel, and fulfillment. You''ve come full circle and achieved your goals.', 'Reversed, The World suggests seeking personal closure, short-cuts, and delays in completion.', ARRAY['completion', 'accomplishment', 'travel', 'fulfillment'], ARRAY['seeking closure', 'short-cuts', 'delays', 'incomplete']);

-- ============================================
-- 003_spread_types.sql
-- ============================================

-- Common tarot spreads

INSERT INTO spread_types (name, description, position_count, positions) VALUES
('Single Card', 'A simple one-card draw for quick guidance or daily insight.', 1, '[
  {"position": 1, "name": "Guidance", "meaning": "What you need to know today"}
]'::jsonb),

('Three Card - Past Present Future', 'A classic spread showing the progression of a situation.', 3, '[
  {"position": 1, "name": "Past", "meaning": "What has led to this situation"},
  {"position": 2, "name": "Present", "meaning": "Current circumstances and energies"},
  {"position": 3, "name": "Future", "meaning": "Where this situation is heading"}
]'::jsonb),

('Three Card - Situation Action Outcome', 'Focuses on understanding a situation and how to act.', 3, '[
  {"position": 1, "name": "Situation", "meaning": "The current state of affairs"},
  {"position": 2, "name": "Action", "meaning": "What you should do"},
  {"position": 3, "name": "Outcome", "meaning": "The likely result of taking that action"}
]'::jsonb),

('Three Card - Mind Body Spirit', 'A holistic view of your wellbeing.', 3, '[
  {"position": 1, "name": "Mind", "meaning": "Your mental state and thoughts"},
  {"position": 2, "name": "Body", "meaning": "Your physical health and energy"},
  {"position": 3, "name": "Spirit", "meaning": "Your spiritual connection and purpose"}
]'::jsonb),

('Five Card - Elements', 'Explores different aspects of a situation using the elements.', 5, '[
  {"position": 1, "name": "Fire - Energy", "meaning": "Your passion and drive"},
  {"position": 2, "name": "Water - Emotions", "meaning": "Your feelings about the situation"},
  {"position": 3, "name": "Air - Thoughts", "meaning": "Your mental perspective"},
  {"position": 4, "name": "Earth - Material", "meaning": "Practical and material aspects"},
  {"position": 5, "name": "Spirit - Essence", "meaning": "The spiritual lesson or core truth"}
]'::jsonb),

('Celtic Cross', 'The most famous tarot spread, offering deep insight into complex situations.', 10, '[
  {"position": 1, "name": "Present", "meaning": "Your current situation"},
  {"position": 2, "name": "Challenge", "meaning": "Obstacles or opposing forces"},
  {"position": 3, "name": "Past", "meaning": "Foundation of the situation"},
  {"position": 4, "name": "Recent Past", "meaning": "Recent events moving away"},
  {"position": 5, "name": "Best Outcome", "meaning": "What you''re working toward"},
  {"position": 6, "name": "Near Future", "meaning": "Events coming into being"},
  {"position": 7, "name": "Attitude", "meaning": "Your position or perspective"},
  {"position": 8, "name": "External Influences", "meaning": "People and energies affecting you"},
  {"position": 9, "name": "Hopes and Fears", "meaning": "Your inner hopes or anxieties"},
  {"position": 10, "name": "Outcome", "meaning": "Final result if path continues"}
]'::jsonb),

('Relationship', 'Explores the dynamics between two people.', 7, '[
  {"position": 1, "name": "You", "meaning": "Your position and feelings"},
  {"position": 2, "name": "The Other", "meaning": "Their position and feelings"},
  {"position": 3, "name": "Connection", "meaning": "The bond between you"},
  {"position": 4, "name": "Strengths", "meaning": "What supports the relationship"},
  {"position": 5, "name": "Challenges", "meaning": "What needs attention"},
  {"position": 6, "name": "Advice", "meaning": "Guidance for moving forward"},
  {"position": 7, "name": "Potential", "meaning": "Where this relationship is headed"}
]'::jsonb),

('Decision Making', 'Helps you evaluate options and make clear choices.', 6, '[
  {"position": 1, "name": "Question", "meaning": "The heart of the decision"},
  {"position": 2, "name": "Option A", "meaning": "Path one and its implications"},
  {"position": 3, "name": "Option B", "meaning": "Path two and its implications"},
  {"position": 4, "name": "What to Consider", "meaning": "Important factors"},
  {"position": 5, "name": "Likely Outcome A", "meaning": "If you choose option A"},
  {"position": 6, "name": "Likely Outcome B", "meaning": "If you choose option B"}
]'::jsonb);

-- ============================================
-- 004_add_marseille_deck.sql
-- ============================================

-- Add Marseille Tarot deck
INSERT INTO decks (name, description, imagery_style) VALUES
('Tarot de Marseille', 'A traditional French tarot deck dating back to the 16th century. Known for its bold, simple imagery and minimal symbolism in the Minor Arcana.', 'Traditional French');

-- Add card meanings for Marseille deck (deck_id = 2)
-- Note: The cards table already has all 78 cards, we just need meanings

-- Major Arcana meanings for Marseille (simplified versions)
INSERT INTO card_meanings (card_id, deck_id, upright_meaning, reversed_meaning, upright_keywords, reversed_keywords) VALUES
-- The Fool (card_id = 1)
(1, 2, 'A journey begins with no clear destination. The Fool walks freely, unburdened by worldly concerns, trusting in divine providence.', 'Folly, poor judgment, recklessness without wisdom. The wanderer loses their way.', ARRAY['journey', 'freedom', 'trust', 'spontaneity', 'divine protection'], ARRAY['recklessness', 'folly', 'lost', 'poor judgment', 'naivety']),

-- The Magician (card_id = 2)
(2, 2, 'Mastery of the four elements. The Magician possesses all tools needed to manifest reality through focused will.', 'Manipulation, trickery, scattered energy. Misuse of power or inability to focus one''s talents.', ARRAY['mastery', 'skill', 'willpower', 'manifestation', 'tools'], ARRAY['manipulation', 'trickery', 'scattered', 'blocked power']),

-- The High Priestess (card_id = 3)
(3, 2, 'Guardian of sacred mysteries. She sits between pillars, holding ancient wisdom that cannot be taught, only experienced.', 'Hidden agendas, secrets causing harm, disconnection from inner knowing.', ARRAY['mystery', 'intuition', 'sacred knowledge', 'inner temple'], ARRAY['secrets', 'hidden agendas', 'disconnection', 'surface knowledge']),

-- The Empress (card_id = 4)
(4, 2, 'Abundance, fertility, the great mother. Nature in full bloom, creative power made manifest.', 'Blocked creativity, barrenness, over-dependence, smothering love.', ARRAY['abundance', 'fertility', 'nature', 'mother', 'creation'], ARRAY['creative block', 'dependence', 'smothering', 'barrenness']),

-- The Emperor (card_id = 5)
(5, 2, 'Authority, structure, the father archetype. Establishment of order through strength and leadership.', 'Tyranny, rigidity, abuse of authority, weak leadership.', ARRAY['authority', 'structure', 'leadership', 'stability', 'order'], ARRAY['tyranny', 'rigidity', 'abuse of power', 'weak leadership']),

-- The Pope/Hierophant (card_id = 6)
(6, 2, 'Spiritual authority, tradition, religious institution. The bridge between heaven and earth.', 'Dogma, false teaching, rigid beliefs, breaking with tradition.', ARRAY['tradition', 'teaching', 'spiritual authority', 'religion'], ARRAY['dogma', 'false teaching', 'rigidity', 'rebellion']),

-- The Lovers (card_id = 7)
(7, 2, 'Choice, union, the crossroads. Love that transforms and demands commitment.', 'Poor choices, separation, misalignment, temptation leading astray.', ARRAY['choice', 'union', 'love', 'commitment', 'alignment'], ARRAY['poor choices', 'separation', 'misalignment', 'temptation']),

-- The Chariot (card_id = 8)
(8, 2, 'Victory through will and control. Harnessing opposing forces to move forward triumphantly.', 'Loss of control, opposition winning, scattered forces, aggression.', ARRAY['victory', 'control', 'triumph', 'willpower', 'direction'], ARRAY['loss of control', 'opposition', 'scattered', 'aggression']),

-- Justice/Strength (card_id = 9)
(9, 2, 'Inner fortitude, courage, gentle mastery. Taming the lion through compassion rather than force.', 'Self-doubt, weakness, fear, abuse of strength.', ARRAY['courage', 'inner strength', 'compassion', 'patience'], ARRAY['self-doubt', 'weakness', 'fear', 'brutality']),

-- The Hermit (card_id = 10)
(10, 2, 'Solitude, inner light, wisdom gained through withdrawal. The lone seeker on the mountain.', 'Isolation, loneliness, refusing guidance, paranoia.', ARRAY['solitude', 'wisdom', 'introspection', 'inner light', 'guidance'], ARRAY['isolation', 'loneliness', 'paranoia', 'withdrawal']),

-- Wheel of Fortune (card_id = 11)
(11, 2, 'The ever-turning wheel, fate, destiny, cycles of life. What rises must fall, what falls will rise.', 'Bad luck, resistance to change, broken cycle.', ARRAY['fate', 'destiny', 'cycles', 'turning point', 'fortune'], ARRAY['bad luck', 'resistance', 'downward cycle']),

-- Strength/Justice (card_id = 12)
(12, 2, 'Balance, fairness, karmic law. The sword of truth cuts through illusion.', 'Injustice, unfairness, dishonesty, karmic debt.', ARRAY['justice', 'fairness', 'truth', 'law', 'karma'], ARRAY['injustice', 'unfairness', 'dishonesty', 'debt']),

-- The Hanged Man (card_id = 13)
(13, 2, 'Suspension, sacrifice, seeing from a new angle. Willing surrender leads to enlightenment.', 'Unnecessary sacrifice, stalling, martyrdom, resistance.', ARRAY['suspension', 'sacrifice', 'new perspective', 'surrender'], ARRAY['stalling', 'martyrdom', 'resistance', 'meaningless sacrifice']),

-- Death (card_id = 14)
(14, 2, 'Transformation, ending, inevitable change. The old must die for the new to be born.', 'Resistance to change, stagnation, partial transformation, fear of endings.', ARRAY['transformation', 'endings', 'change', 'transition', 'rebirth'], ARRAY['resistance', 'stagnation', 'fear', 'incomplete change']),

-- Temperance (card_id = 15)
(15, 2, 'Balance, moderation, alchemy, the middle path. Blending opposites to create harmony.', 'Imbalance, excess, lack of moderation, disharmony.', ARRAY['balance', 'moderation', 'alchemy', 'harmony', 'patience'], ARRAY['imbalance', 'excess', 'disharmony', 'extremes']),

-- The Devil (card_id = 16)
(16, 2, 'Material bondage, shadow self, earthly pleasures. Chains that seem unbreakable but are self-imposed.', 'Release from bondage, breaking chains, enlightenment about attachments.', ARRAY['bondage', 'materialism', 'shadow', 'addiction', 'illusion'], ARRAY['release', 'breaking free', 'revelation', 'detachment']),

-- The Tower (card_id = 17)
(17, 2, 'Sudden upheaval, divine intervention, the lightning bolt. Structures built on false foundations crumble.', 'Avoiding disaster, fear of change, delaying the inevitable.', ARRAY['upheaval', 'sudden change', 'revelation', 'breakdown', 'liberation'], ARRAY['avoiding disaster', 'fear', 'resistance', 'delayed collapse']),

-- The Star (card_id = 18)
(18, 2, 'Hope, inspiration, spiritual renewal. The calm after the storm, healing waters.', 'Lack of faith, despair, disconnection from spirit, pessimism.', ARRAY['hope', 'inspiration', 'renewal', 'faith', 'healing'], ARRAY['despair', 'lack of faith', 'pessimism', 'disconnection']),

-- The Moon (card_id = 19)
(19, 2, 'Illusion, mystery, the unconscious mind. Walking between the pillars into unknown territory.', 'Clarity emerging, facing fears, releasing illusions.', ARRAY['illusion', 'mystery', 'unconscious', 'intuition', 'dreams'], ARRAY['clarity', 'facing fears', 'release', 'truth revealed']),

-- The Sun (card_id = 20)
(20, 2, 'Joy, success, clarity, vitality. The light of consciousness illuminates all.', 'Temporary setback, diminished joy, delayed success.', ARRAY['success', 'joy', 'vitality', 'clarity', 'celebration'], ARRAY['temporary setback', 'diminished', 'clouded', 'delayed']),

-- Judgement (card_id = 21)
(21, 2, 'Awakening, resurrection, final judgment. The call to rise to a higher level of consciousness.', 'Self-doubt, refusal to learn, harsh judgment, inability to forgive.', ARRAY['awakening', 'renewal', 'absolution', 'judgment', 'calling'], ARRAY['self-doubt', 'harsh judgment', 'refusal', 'unable to forgive']),

-- The World (card_id = 22)
(22, 2, 'Completion, fulfillment, cosmic consciousness. The dance of the soul at the end of its journey.', 'Incompletion, lack of closure, shortcuts, emptiness.', ARRAY['completion', 'fulfillment', 'achievement', 'cosmic dance'], ARRAY['incompletion', 'lack of closure', 'emptiness', 'seeking shortcuts']);

-- Note: For a complete implementation, you would continue adding meanings for all 78 cards
-- This includes the 56 Minor Arcana cards (Ace through King of Wands, Cups, Swords, Pentacles)
-- The Marseille deck traditionally has less detailed Minor Arcana imagery, so meanings
-- focus more on numerology and elemental associations

-- Complete Minor Arcana for Marseille deck
INSERT INTO card_meanings (card_id, deck_id, upright_meaning, reversed_meaning, upright_keywords, reversed_keywords) VALUES
-- WANDS SUIT (Fire element - Action, Creativity, Passion)
-- Ace of Wands (card_id = 23)
(23, 2, 'The root of fire. Pure creative energy, the spark of inspiration, new projects begun with passion.', 'False starts, creative blocks, scattered energy.', ARRAY['inspiration', 'creative spark', 'new project', 'enthusiasm'], ARRAY['false start', 'creative block', 'scattered', 'delays']),
-- Two of Wands (card_id = 24)
(24, 2, 'Dominion. Planning and personal power. Standing between two staffs, surveying the domain.', 'Fear of unknown, lack of planning, poor decisions.', ARRAY['planning', 'personal power', 'bold decisions'], ARRAY['fear', 'poor planning', 'indecision']),
-- Three of Wands (card_id = 25)
(25, 2, 'Established strength. Foundations laid, looking forward to expansion and growth.', 'Delays in progress, obstacles, lack of foresight.', ARRAY['expansion', 'foresight', 'enterprise'], ARRAY['delays', 'obstacles', 'narrow vision']),
-- Four of Wands (card_id = 26)
(26, 2, 'Completion. Harmony, celebration, homecoming. The structure is complete and stable.', 'Unstable foundation, disruption, cancelled celebrations.', ARRAY['celebration', 'harmony', 'completion', 'home'], ARRAY['instability', 'disruption', 'cancelled plans']),
-- Five of Wands (card_id = 27)
(27, 2, 'Strife. Competition, conflict, struggle for dominance. Many wills colliding.', 'Avoiding conflict, inner discord, compromise.', ARRAY['conflict', 'competition', 'struggle'], ARRAY['avoidance', 'inner conflict', 'resolution']),
-- Six of Wands (card_id = 28)
(28, 2, 'Victory. Public recognition, triumph after struggle, leadership acknowledged.', 'Private success, egotism, fall from grace.', ARRAY['victory', 'recognition', 'triumph', 'leadership'], ARRAY['egotism', 'private success', 'deflated ego']),
-- Seven of Wands (card_id = 29)
(29, 2, 'Valor. Courage in the face of opposition, defending one''s position against all comers.', 'Overwhelmed, giving up, feeling defensive.', ARRAY['courage', 'defense', 'perseverance'], ARRAY['overwhelmed', 'giving up', 'paranoia']),
-- Eight of Wands (card_id = 30)
(30, 2, 'Swiftness. Rapid action, messages flying, sudden progress. Energy in motion.', 'Delays, frustration, slowed momentum.', ARRAY['speed', 'action', 'messages', 'progress'], ARRAY['delays', 'frustration', 'slowness']),
-- Nine of Wands (card_id = 31)
(31, 2, 'Strength in reserve. Battle-tested but still standing, prepared for one last fight.', 'Exhaustion, paranoia, unable to defend.', ARRAY['resilience', 'persistence', 'prepared'], ARRAY['exhaustion', 'paranoia', 'collapse']),
-- Ten of Wands (card_id = 32)
(32, 2, 'Oppression. Carrying heavy burdens, overwhelmed by responsibility, nearing the end.', 'Release of burdens, delegation, collapse under weight.', ARRAY['burden', 'responsibility', 'overwhelm'], ARRAY['release', 'delegation', 'burnout']),
-- Page of Wands (card_id = 33)
(33, 2, 'The messenger of fire. Enthusiastic news, creative beginnings, youthful energy.', 'Bad news, immaturity, scattered enthusiasm.', ARRAY['enthusiasm', 'exploration', 'news'], ARRAY['bad news', 'immaturity', 'recklessness']),
-- Knight of Wands (card_id = 34)
(34, 2, 'The warrior of fire. Passionate action, adventure, impulsive pursuit of goals.', 'Recklessness, haste, angry outbursts.', ARRAY['action', 'passion', 'adventure', 'impulsiveness'], ARRAY['recklessness', 'haste', 'anger']),
-- Queen of Wands (card_id = 35)
(35, 2, 'The queen of fire. Confident, charismatic, creative leadership. Magnetic personality.', 'Jealousy, demanding, temperamental.', ARRAY['confidence', 'charisma', 'creativity', 'leadership'], ARRAY['jealousy', 'demanding', 'temperamental']),
-- King of Wands (card_id = 36)
(36, 2, 'The king of fire. Visionary leader, entrepreneur, master of creative enterprise.', 'Tyranny, domineering, ruthless ambition.', ARRAY['leadership', 'vision', 'entrepreneur', 'mastery'], ARRAY['tyranny', 'ruthless', 'domineering']),

-- CUPS SUIT (Water element - Emotions, Relationships, Intuition)
-- Ace of Cups (card_id = 37)
(37, 2, 'The root of water. Overflowing emotion, new love, spiritual abundance.', 'Emotional blockage, emptiness, repressed feelings.', ARRAY['love', 'emotion', 'abundance', 'new relationship'], ARRAY['blocked emotions', 'emptiness', 'repression']),
-- Two of Cups (card_id = 38)
(38, 2, 'Love. Partnership, union, mutual attraction. Two souls meeting in harmony.', 'Disharmony, broken relationship, imbalance.', ARRAY['partnership', 'union', 'attraction', 'harmony'], ARRAY['disharmony', 'breakup', 'imbalance']),
-- Three of Cups (card_id = 39)
(39, 2, 'Abundance. Celebration, friendship, community. Joyful gathering.', 'Overindulgence, gossip, isolation from group.', ARRAY['celebration', 'friendship', 'community', 'joy'], ARRAY['overindulgence', 'gossip', 'isolation']),
-- Four of Cups (card_id = 40)
(40, 2, 'Luxury turned to apathy. Boredom with abundance, overlooking new opportunities.', 'New awareness, acceptance, seizing opportunity.', ARRAY['apathy', 'contemplation', 'boredom'], ARRAY['awareness', 'acceptance', 'motivation']),
-- Five of Cups (card_id = 41)
(41, 2, 'Loss. Grief, disappointment, focusing on what''s lost rather than what remains.', 'Acceptance, moving on, finding silver lining.', ARRAY['loss', 'grief', 'disappointment', 'regret'], ARRAY['acceptance', 'moving on', 'recovery']),
-- Six of Cups (card_id = 42)
(42, 2, 'Pleasure. Nostalgia, childhood memories, innocence, reunion with the past.', 'Living in the past, stuck in memories, refusing to grow.', ARRAY['nostalgia', 'memories', 'innocence', 'reunion'], ARRAY['stuck in past', 'refusing growth', 'rose-tinted']),
-- Seven of Cups (card_id = 43)
(43, 2, 'Debauch. Illusion, fantasy, too many choices. Confusion of desires.', 'Clarity, making choices, dispelling illusions.', ARRAY['illusion', 'fantasy', 'choices', 'confusion'], ARRAY['clarity', 'decision', 'reality']),
-- Eight of Cups (card_id = 44)
(44, 2, 'Indolence. Walking away from emotional investment, seeking higher purpose.', 'Fear of change, stagnation, avoiding the journey.', ARRAY['departure', 'seeking truth', 'abandonment'], ARRAY['fear of change', 'stagnation', 'avoidance']),
-- Nine of Cups (card_id = 45)
(45, 2, 'Happiness. Contentment, satisfaction, wishes fulfilled. Emotional abundance.', 'Greed, dissatisfaction, superficial happiness.', ARRAY['satisfaction', 'contentment', 'wishes', 'abundance'], ARRAY['greed', 'dissatisfaction', 'smugness']),
-- Ten of Cups (card_id = 46)
(46, 2, 'Satiety. Perfect emotional fulfillment, family harmony, lasting happiness.', 'Broken family, disconnection, unrealistic expectations.', ARRAY['fulfillment', 'family', 'harmony', 'happiness'], ARRAY['broken family', 'disconnection', 'unrealistic']),
-- Page of Cups (card_id = 47)
(47, 2, 'The messenger of water. Emotional beginnings, creative intuition, gentle messages.', 'Emotional immaturity, creative blocks, bad emotional news.', ARRAY['creativity', 'intuition', 'gentleness', 'messages'], ARRAY['immaturity', 'moodiness', 'blocked creativity']),
-- Knight of Cups (card_id = 48)
(48, 2, 'The warrior of water. Romantic pursuit, following the heart, artistic inspiration.', 'Moodiness, unrealistic romanticism, jealousy.', ARRAY['romance', 'charm', 'idealism', 'artistic'], ARRAY['moodiness', 'unrealistic', 'jealousy']),
-- Queen of Cups (card_id = 49)
(49, 2, 'The queen of water. Emotional depth, intuitive wisdom, compassionate nurturing.', 'Emotional instability, manipulation, martyrdom.', ARRAY['intuition', 'compassion', 'nurturing', 'emotional depth'], ARRAY['manipulation', 'instability', 'martyrdom']),
-- King of Cups (card_id = 50)
(50, 2, 'The king of water. Emotional mastery, diplomatic wisdom, controlled compassion.', 'Emotional manipulation, coldness, repression.', ARRAY['emotional control', 'wisdom', 'diplomacy', 'compassion'], ARRAY['manipulation', 'coldness', 'repression']),

-- SWORDS SUIT (Air element - Thought, Conflict, Communication)
-- Ace of Swords (card_id = 51)
(51, 2, 'The root of air. Mental clarity, breakthrough, truth cutting through confusion.', 'Confusion, mental blocks, misused power.', ARRAY['clarity', 'breakthrough', 'truth', 'mental power'], ARRAY['confusion', 'blocked', 'clouded judgment']),
-- Two of Swords (card_id = 52)
(52, 2, 'Peace. Truce, stalemate, difficult choice avoided. Balanced but immobile.', 'Information revealed, decision made, end of stalemate.', ARRAY['stalemate', 'truce', 'avoidance', 'balance'], ARRAY['decision', 'revelation', 'movement']),
-- Three of Swords (card_id = 53)
(53, 2, 'Sorrow. Heartbreak, painful truth, necessary suffering. The pierced heart.', 'Recovery from heartbreak, forgiveness, moving forward.', ARRAY['heartbreak', 'sorrow', 'painful truth', 'grief'], ARRAY['recovery', 'forgiveness', 'healing']),
-- Four of Swords (card_id = 54)
(54, 2, 'Truce. Rest, recuperation, meditation. The calm before the next battle.', 'Restlessness, burnout, refusal to rest.', ARRAY['rest', 'recuperation', 'meditation', 'truce'], ARRAY['restlessness', 'burnout', 'stagnation']),
-- Five of Swords (card_id = 55)
(55, 2, 'Defeat. Hollow victory, conflict with loss on all sides, shameful retreat.', 'Reconciliation, making amends, pride swallowed.', ARRAY['defeat', 'conflict', 'hollow victory', 'shame'], ARRAY['reconciliation', 'amends', 'forgiveness']),
-- Six of Swords (card_id = 56)
(56, 2, 'Science. Transition, moving toward calmer waters, leaving troubles behind.', 'Resistance to change, unable to move on, rough passage.', ARRAY['transition', 'moving on', 'travel', 'recovery'], ARRAY['resistance', 'stuck', 'turbulence']),
-- Seven of Swords (card_id = 57)
(57, 2, 'Futility. Strategy, deception, getting away with something. Lone wolf tactics.', 'Confession, coming clean, imposter syndrome.', ARRAY['strategy', 'deception', 'stealth', 'cunning'], ARRAY['confession', 'exposure', 'honesty']),
-- Eight of Swords (card_id = 58)
(58, 2, 'Interference. Self-imposed restriction, victim mentality, perceived helplessness.', 'Self-liberation, new perspective, escape.', ARRAY['restriction', 'victim', 'helpless', 'trapped'], ARRAY['liberation', 'escape', 'new perspective']),
-- Nine of Swords (card_id = 59)
(59, 2, 'Cruelty. Anxiety, nightmares, mental anguish. The darkest hour before dawn.', 'Recovery from anxiety, facing fears, reaching out for help.', ARRAY['anxiety', 'nightmares', 'despair', 'worry'], ARRAY['recovery', 'facing fears', 'hope']),
-- Ten of Swords (card_id = 60)
(60, 2, 'Ruin. Rock bottom, painful ending, betrayal. The worst is over.', 'Recovery, regeneration, inevitable end passed.', ARRAY['ending', 'betrayal', 'rock bottom', 'ruin'], ARRAY['recovery', 'regeneration', 'moving on']),
-- Page of Swords (card_id = 61)
(61, 2, 'The messenger of air. Curious mind, vigilance, tactical thinking. Mental energy.', 'Gossip, cunning, all talk no action.', ARRAY['curiosity', 'vigilance', 'mental energy'], ARRAY['gossip', 'cunning', 'all talk']),
-- Knight of Swords (card_id = 62)
(62, 2, 'The warrior of air. Swift action, incisive intellect, charging forward without thought.', 'Reckless haste, cruelty, oppressive force.', ARRAY['action', 'intellect', 'directness', 'swift'], ARRAY['reckless', 'cruel', 'oppressive']),
-- Queen of Swords (card_id = 63)
(63, 2, 'The queen of air. Clear judgment, independence, sharp mind. Truth over comfort.', 'Cold cruelty, bitterness, harsh judgment.', ARRAY['clear judgment', 'independence', 'truth', 'perception'], ARRAY['cruelty', 'bitterness', 'harsh']),
-- King of Swords (card_id = 64)
(64, 2, 'The king of air. Intellectual authority, logical judgment, ethical power.', 'Manipulative intellect, tyrannical judgment, abuse of mental power.', ARRAY['authority', 'logic', 'judgment', 'ethics'], ARRAY['manipulation', 'tyranny', 'abuse of power']),

-- PENTACLES SUIT (Earth element - Material, Physical, Practical)
-- Ace of Pentacles (card_id = 65)
(65, 2, 'The root of earth. Material opportunity, new financial beginning, manifestation.', 'Lost opportunity, poor planning, lack of foresight.', ARRAY['opportunity', 'prosperity', 'new beginning', 'manifestation'], ARRAY['lost chance', 'poor planning', 'greed']),
-- Two of Pentacles (card_id = 66)
(66, 2, 'Change. Juggling priorities, adaptability, maintaining balance in flux.', 'Overwhelmed, disorganization, dropping the ball.', ARRAY['balance', 'adaptability', 'juggling', 'flexibility'], ARRAY['overwhelmed', 'disorganized', 'imbalance']),
-- Three of Pentacles (card_id = 67)
(67, 2, 'Works. Teamwork, collaboration, skilled craftsmanship recognized.', 'Disharmony in team, lack of recognition, poor work.', ARRAY['teamwork', 'collaboration', 'skill', 'recognition'], ARRAY['disharmony', 'lack of teamwork', 'poor quality']),
-- Four of Pentacles (card_id = 68)
(68, 2, 'Power. Security through possession, control, holding tight. Stability or greed.', 'Generosity, letting go, financial insecurity.', ARRAY['security', 'control', 'conservation', 'possession'], ARRAY['generosity', 'letting go', 'insecurity']),
-- Five of Pentacles (card_id = 69)
(69, 2, 'Worry. Financial hardship, isolation, feeling left out in the cold.', 'Recovery, improved finances, charity received.', ARRAY['hardship', 'poverty', 'isolation', 'worry'], ARRAY['recovery', 'charity', 'improvement']),
-- Six of Pentacles (card_id = 70)
(70, 2, 'Success. Generosity, charity, fair distribution. Giving and receiving in balance.', 'Strings attached, unfair conditions, inequality.', ARRAY['generosity', 'charity', 'fairness', 'balance'], ARRAY['strings attached', 'debt', 'unfairness']),
-- Seven of Pentacles (card_id = 71)
(71, 2, 'Failure. Pause to assess, long-term view, patience or frustration with slow growth.', 'Impatience, lack of results, poor investment.', ARRAY['assessment', 'patience', 'long-term', 'reflection'], ARRAY['impatience', 'frustration', 'poor returns']),
-- Eight of Pentacles (card_id = 72)
(72, 2, 'Prudence. Diligent work, skill development, mastery through practice.', 'Poor quality, lack of focus, wasted effort.', ARRAY['diligence', 'skill', 'mastery', 'dedication'], ARRAY['poor quality', 'lack of focus', 'shortcuts']),
-- Nine of Pentacles (card_id = 73)
(73, 2, 'Gain. Self-sufficiency, financial independence, enjoying the fruits of labor.', 'Over-investment in work, financial setbacks, lack of independence.', ARRAY['independence', 'self-sufficiency', 'luxury', 'success'], ARRAY['setback', 'dependence', 'financial loss']),
-- Ten of Pentacles (card_id = 74)
(74, 2, 'Wealth. Legacy, inheritance, long-term security. Material completion.', 'Financial failure, family disputes, lack of legacy.', ARRAY['wealth', 'legacy', 'inheritance', 'family'], ARRAY['financial failure', 'disputes', 'instability']),
-- Page of Pentacles (card_id = 75)
(75, 2, 'The messenger of earth. New learning, practical opportunities, manifestation of ideas.', 'Lack of progress, poor planning, unrealistic.', ARRAY['study', 'opportunity', 'manifestation', 'practicality'], ARRAY['lack of progress', 'procrastination', 'unrealistic']),
-- Knight of Pentacles (card_id = 76)
(76, 2, 'The warrior of earth. Methodical progress, reliability, responsible action.', 'Stubbornness, sluggishness, boredom with routine.', ARRAY['reliability', 'method', 'responsibility', 'persistence'], ARRAY['stubbornness', 'sluggish', 'boring']),
-- Queen of Pentacles (card_id = 77)
(77, 2, 'The queen of earth. Practical nurturing, material security, down-to-earth wisdom.', 'Material neglect, work-life imbalance, smothering.', ARRAY['nurturing', 'practical', 'security', 'abundance'], ARRAY['neglect', 'imbalance', 'smothering']),
-- King of Pentacles (card_id = 78)
(78, 2, 'The king of earth. Material mastery, business success, reliable provider.', 'Greed, materialism, stubborn, financially inept.', ARRAY['mastery', 'success', 'provider', 'stability'], ARRAY['greed', 'materialism', 'stubborn', 'inept']);

-- ============================================
-- 005_add_thoth_deck.sql
-- ============================================

-- Add Thoth Tarot deck (Aleister Crowley)
INSERT INTO decks (name, description, imagery_style) VALUES
('Thoth Tarot', 'Created by Aleister Crowley and painted by Lady Frieda Harris. Known for its rich Egyptian symbolism, Qabalalistic correspondences, and esoteric depth. Features unique card names like "Lust" for Strength and "Art" for Temperance.', 'Occult/Egyptian');

-- Card meanings for Thoth deck (deck_id = 3)
-- The Thoth deck has some renamed Major Arcana and emphasizes astrological/alchemical symbolism

INSERT INTO card_meanings (card_id, deck_id, upright_meaning, reversed_meaning, upright_keywords, reversed_keywords) VALUES
-- Major Arcana for Thoth (with Crowley's interpretations)
(1, 3, 'The Fool represents pure divine energy before manifestation. Zero, the void, infinite potential. The cosmic wanderer at the edge of the abyss, ready to take the leap into experience.', 'Mania, thoughtlessness, divine folly turned to mere foolishness.', ARRAY['zero', 'divine folly', 'infinite potential', 'cosmic energy', 'the abyss'], ARRAY['mania', 'thoughtlessness', 'recklessness', 'chaos']),

(2, 3, 'The Magus (Magician) represents conscious will manifesting reality. Mercury, communication, skill. "I am the secret serpent coiled about to spring." Master of the four elemental weapons.', 'Trickery, manipulation, scattered will, abuse of magical power.', ARRAY['will', 'communication', 'mercury', 'skill', 'manifestation'], ARRAY['trickery', 'manipulation', 'scattered will', 'deception']),

(3, 3, 'The High Priestess embodies the purest form of divine feminine energy. The Moon, veils of Isis, keeper of the mysteries. She sits between the pillars of severity and mercy, guardian of the unconscious.', 'Secrets kept harmfully, disconnection from the divine feminine, superficiality.', ARRAY['divine feminine', 'mystery', 'the moon', 'unconscious', 'isis'], ARRAY['secrets', 'superficiality', 'disconnected', 'veiled truth']),

(4, 3, 'The Empress represents Venus, the gate of heaven, the mother of all living things. Luxury, abundance, creative force made manifest in the material world.', 'Creative stagnation, barrenness, luxuryturned to excess.', ARRAY['venus', 'abundance', 'mother', 'creative force', 'luxury'], ARRAY['stagnation', 'excess', 'barrenness', 'creative block']),

(5, 3, 'The Emperor is Mars, Aries, paternal authority. Structure through will, the father archetype establishing dominion and order. The stone seat of authority.', 'Tyranny, weak authority, structure without flexibility, patriarchal oppression.', ARRAY['authority', 'mars', 'structure', 'dominion', 'father'], ARRAY['tyranny', 'weak authority', 'oppression', 'rigidity']),

(6, 3, 'The Hierophant represents Taurus, tradition, spiritual teaching. The link between divine and earthly wisdom. Conformity to proven spiritual paths.', 'Dogma, false teaching, breaking from tradition unnecessarily, spiritual materialism.', ARRAY['tradition', 'teaching', 'taurus', 'spiritual authority'], ARRAY['dogma', 'false teaching', 'spiritual materialism']),

(7, 3, 'The Lovers represents Gemini, choice, union of opposites. The divine marriage, the oracle, the crossroads where choice determines destiny.', 'Poor choices, separation, disharmony between opposites.', ARRAY['choice', 'gemini', 'union', 'oracle', 'divine marriage'], ARRAY['poor choice', 'separation', 'disharmony']),

(8, 3, 'The Chariot represents Cancer, the grail, victory through control of opposing forces. The charioteer commands both black and white sphinxes in perfect balance.', 'Loss of control, forces in opposition, directionless movement.', ARRAY['victory', 'control', 'cancer', 'balance', 'triumph'], ARRAY['loss of control', 'opposition', 'directionless']),

(9, 3, 'Lust (Strength in RWS) represents Leo, passionate life force, courage. The woman rides the beast, showing that true strength is passionate engagement with life, not suppression.', 'Weakness, passionless existence, fear of passion, cowardice.', ARRAY['passion', 'leo', 'courage', 'life force', 'engagement'], ARRAY['weakness', 'passionless', 'cowardice', 'fear']),

(10, 3, 'The Hermit represents Virgo, solitary search for truth, inner light. The wise one withdraws to find the lamp of wisdom that can guide others.', 'Isolation without purpose, loneliness, refusing wisdom, fear of solitude.', ARRAY['solitude', 'virgo', 'wisdom', 'inner light', 'search'], ARRAY['isolation', 'loneliness', 'fear', 'purposeless']),

(11, 3, 'Fortune represents Jupiter, the wheel of fate, karma, cycles. The Sphinx, monkey, and serpent represent destiny, intellect, and transformation circling the ever-turning wheel.', 'Bad luck, resistance to destiny, breaking harmful cycles.', ARRAY['fortune', 'jupiter', 'cycles', 'destiny', 'karma'], ARRAY['bad luck', 'resistance', 'broken cycles']),

(12, 3, 'Adjustment (Justice in RWS) represents Libra, balance, truth, karma. The scales and sword of cosmic equilibrium. What is earned is received.', 'Imbalance, injustice, karmic debt, harsh judgment.', ARRAY['balance', 'libra', 'truth', 'karma', 'adjustment'], ARRAY['imbalance', 'injustice', 'debt', 'harshness']),

(13, 3, 'The Hanged Man represents Water, suspension, the sacrifice of the dying god. Surrender to achieve enlightenment, seeing from a new perspective through willing sacrifice.', 'Unnecessary sacrifice, resistance to surrender, stagnation.', ARRAY['sacrifice', 'water', 'surrender', 'enlightenment', 'new perspective'], ARRAY['unnecessary sacrifice', 'resistance', 'stagnation']),

(14, 3, 'Death represents Scorpio, transformation, putrefaction and rebirth. The skeleton of transformation dances on decay. Death is not the end but metamorphosis.', 'Resistance to change, stagnation, incomplete transformation.', ARRAY['transformation', 'scorpio', 'rebirth', 'metamorphosis', 'change'], ARRAY['resistance', 'stagnation', 'incomplete', 'fear of death']),

(15, 3, 'Art (Temperance in RWS) represents Sagittarius, alchemy, the rainbow, integration. The alchemical marriage of fire and water, sun and moon, creating the philosopher''s stone.', 'Imbalance, failed alchemy, extremes, disintegration.', ARRAY['alchemy', 'sagittarius', 'integration', 'art', 'balance'], ARRAY['imbalance', 'extremes', 'disintegration', 'failed alchemy']),

(16, 3, 'The Devil represents Capricorn, Pan, material creation, the horned god. Mirth and earthly pleasure. Not evil, but the creative force in material form.', 'Oppression, materialism without joy, bondage, loss of mirth.', ARRAY['capricorn', 'pan', 'mirth', 'creativity', 'material force'], ARRAY['oppression', 'joyless materialism', 'bondage']),

(17, 3, 'The Tower represents Mars, the eye of Horus, destruction of false structures. The lightning bolt of divine revelation destroys all that is not true.', 'Avoiding necessary destruction, clinging to false structures, fear of change.', ARRAY['destruction', 'mars', 'revelation', 'truth', 'lightning'], ARRAY['avoidance', 'clinging', 'fear', 'false structures']),

(18, 3, 'The Star represents Aquarius, hope, the Goddess Nuit pouring the waters of life. Inspiration, the soul drinking from cosmic fountains.', 'Loss of hope, disconnection from divine source, despair.', ARRAY['hope', 'aquarius', 'inspiration', 'cosmic waters', 'nuit'], ARRAY['despair', 'disconnection', 'hopelessness']),

(19, 3, 'The Moon represents Pisces, illusion, the path between towers, journeying through the unconscious. The crayfish of evolution emerges from primordial waters.', 'Emerging clarity, facing the shadow, dispelling illusions.', ARRAY['illusion', 'pisces', 'unconscious', 'evolution', 'mystery'], ARRAY['clarity', 'facing shadow', 'dispelling illusion']),

(20, 3, 'The Sun represents the Sun, glory, the crowned and conquering child. Illumination, joy, the light of consciousness. The two children represent duality resolved in unity.', 'False confidence, diminished glory, clouded vision.', ARRAY['sun', 'glory', 'joy', 'consciousness', 'illumination'], ARRAY['false confidence', 'clouded', 'diminished']),

(21, 3, 'The Aeon (Judgment in RWS) represents Fire, Pluto, the new aeon. Horus rising, transformation to a new age. Not judgment but cosmic shift and rebirth.', 'Refusal to evolve, clinging to old aeon, resistance to cosmic change.', ARRAY['new aeon', 'fire', 'transformation', 'horus', 'cosmic shift'], ARRAY['resistance', 'old ways', 'refusal to evolve']),

(22, 3, 'The Universe (The World in RWS) represents Saturn, completion, cosmic dance. The dancing goddess within the cosmic egg. All is achieved, the great work completed.', 'Incompletion, seeking shortcuts, inability to finish the great work.', ARRAY['completion', 'saturn', 'cosmic dance', 'universe', 'achievement'], ARRAY['incompletion', 'shortcuts', 'unfinished']);

-- Note: For a complete implementation, you would add all 56 Minor Arcana cards
-- The Thoth deck uses different court card names: Princess (Page), Prince (Knight), Queen, Knight (King)
-- Minor Arcana emphasizes elemental dignities and astrological correspondences

-- Sample Minor Arcana (you would complete all 56)
INSERT INTO card_meanings (card_id, deck_id, upright_meaning, reversed_meaning, upright_keywords, reversed_keywords) VALUES
(23, 3, 'Ace of Wands: The root of the powers of fire. Pure creative will, the phallus, the flame of life ignited.', 'Creative force blocked, impotence, extinguished flame.', ARRAY['root of fire', 'creative will', 'life force', 'ignition'], ARRAY['blocked', 'impotence', 'extinguished']),

(24, 3, 'Two of Wands (Dominion): Mars in Aries. Established strength, the will imposed on reality, dominion over the realm.', 'Weak dominion, failed control, scattered will.', ARRAY['dominion', 'mars in aries', 'strength', 'control'], ARRAY['weak control', 'scattered', 'failed dominion']);

-- Continue for remaining cards...

-- ============================================
-- 006_add_wild_unknown_deck.sql
-- ============================================

-- Add Wild Unknown Tarot deck (Kim Krans)
INSERT INTO decks (name, description, imagery_style) VALUES
('Wild Unknown Tarot', 'Created by Kim Krans. A modern, minimalist deck featuring animals and nature imagery in black, white, and rainbow colors. Known for its intuitive symbolism and accessible approach.', 'Modern/Nature');

-- Card meanings for Wild Unknown deck (deck_id = 4)
-- This deck emphasizes animal symbolism and natural cycles

INSERT INTO card_meanings (card_id, deck_id, upright_meaning, reversed_meaning, upright_keywords, reversed_keywords) VALUES
-- Major Arcana for Wild Unknown
(1, 4, 'The Fool: A small bird on a branch, ready to take flight into the unknown. Trust, new beginnings, the leap into experience with open heart and mind.', 'Fear of the leap, recklessness, refusing the journey.', ARRAY['beginnings', 'trust', 'leap', 'innocence', 'bird'], ARRAY['fear', 'recklessness', 'refusal']),

(2, 4, 'The Magician: A leopard with tools of the four elements. Skill, manifestation, harnessing natural power with precision and grace.', 'Manipulation, misused skill, predatory behavior.', ARRAY['skill', 'manifestation', 'precision', 'leopard', 'power'], ARRAY['manipulation', 'misuse', 'predatory']),

(3, 4, 'The High Priestess: A moth drawn to moonlight. Intuition, mystery, nocturnal wisdom. Trust the pull toward hidden knowledge.', 'Ignoring intuition, superficiality, fear of the dark.', ARRAY['intuition', 'mystery', 'moth', 'moonlight', 'nocturnal'], ARRAY['ignored intuition', 'superficial', 'fear']),

(4, 4, 'The Empress: A peacock in full display. Abundance, beauty, creative confidence, showing your true colors to the world.', 'Creative blocks, hiding beauty, vanity, false display.', ARRAY['abundance', 'beauty', 'peacock', 'creative', 'display'], ARRAY['blocks', 'hiding', 'vanity']),

(5, 4, 'The Emperor: A horned ram, strong and grounded. Authority through natural presence, establishing boundaries, primal leadership.', 'Tyranny, weak boundaries, stubborn aggression.', ARRAY['authority', 'ram', 'boundaries', 'leadership', 'grounded'], ARRAY['tyranny', 'weak', 'aggression']),

(6, 4, 'The Hierophant: An elk with magnificent antlers. Ancient wisdom, traditional paths, connection to ancestral knowledge.', 'Rigid traditions, refusing wisdom, breaking from necessary structure.', ARRAY['tradition', 'elk', 'wisdom', 'ancestral', 'antlers'], ARRAY['rigidity', 'refusing wisdom', 'rebellion']),

(7, 4, 'The Lovers: Two swans forming a heart. Partnership, choice, union, mirroring souls meeting in harmony.', 'Disharmony, poor choices, separation, broken reflection.', ARRAY['partnership', 'swans', 'choice', 'union', 'harmony'], ARRAY['disharmony', 'separation', 'poor choice']),

(8, 4, 'The Chariot: A charging lion. Determination, controlled power, victory through focused will and courage.', 'Loss of control, scattered energy, cowardice.', ARRAY['determination', 'lion', 'power', 'victory', 'courage'], ARRAY['lost control', 'scattered', 'cowardice']),

(9, 4, 'Strength: A wild cat bridging two realms. Gentle courage, patient strength, bridging the civilized and wild self.', 'Weakness, impatience, disconnect from wild self.', ARRAY['courage', 'wild cat', 'bridging', 'patience', 'gentleness'], ARRAY['weakness', 'impatience', 'disconnect']),

(10, 4, 'The Hermit: A snail carrying its home, moving slowly inward. Solitude, self-sufficiency, the wisdom found in slowing down.', 'Isolation, refusal to emerge, stagnant withdrawal.', ARRAY['solitude', 'snail', 'slow', 'wisdom', 'inward'], ARRAY['isolation', 'refusal', 'stagnant']),

(11, 4, 'Wheel of Fortune: A butterfly emerging from chrysalis. Cycles, transformation, the ever-turning wheel of change and rebirth.', 'Resisting change, stuck in cocoon, broken cycles.', ARRAY['cycles', 'butterfly', 'transformation', 'change', 'rebirth'], ARRAY['resistance', 'stuck', 'broken']),

(12, 4, 'Justice: A wild cat balanced on scales. Natural equilibrium, karmic balance, truth in the law of nature.', 'Imbalance, injustice, disrupted ecosystems.', ARRAY['balance', 'cat', 'justice', 'equilibrium', 'karma'], ARRAY['imbalance', 'injustice', 'disrupted']),

(13, 4, 'The Hanged Man: A bat hanging inverted. New perspective through inversion, surrender to find wisdom, seeing in darkness.', 'Unnecessary suffering, refusing new perspective, fear of surrender.', ARRAY['perspective', 'bat', 'surrender', 'inversion', 'darkness'], ARRAY['suffering', 'refusal', 'fear']),

(14, 4, 'Death: A crow among bones. Natural transformation, the necessary death for rebirth, the cycle of decay and renewal.', 'Resisting necessary endings, clinging to decay, fear of transformation.', ARRAY['transformation', 'crow', 'death', 'renewal', 'cycles'], ARRAY['resistance', 'clinging', 'fear']),

(15, 4, 'Temperance: A crane standing in balance. Patience, natural flow, standing in both water and air with perfect equilibrium.', 'Imbalance, rushing, losing equilibrium, disrupted flow.', ARRAY['balance', 'crane', 'patience', 'flow', 'equilibrium'], ARRAY['imbalance', 'rushing', 'disrupted']),

(16, 4, 'The Devil: A chained black cat. Bondage to material world, instinct over consciousness, beautiful beast in chains.', 'Breaking chains, liberation, conscious choice over instinct.', ARRAY['bondage', 'chains', 'black cat', 'material', 'instinct'], ARRAY['liberation', 'breaking free', 'choice']),

(17, 4, 'The Tower: Lightning striking, shattering structures. Sudden upheaval, necessary destruction, natural disaster clearing the way.', 'Avoiding collapse, fear of change, partial destruction.', ARRAY['upheaval', 'lightning', 'destruction', 'clearing', 'sudden'], ARRAY['avoidance', 'fear', 'partial']),

(18, 4, 'The Star: A starfish with seven points. Hope, inspiration, natural regeneration, the star of the sea showing the way.', 'Lost hope, disconnection from natural rhythms, lack of inspiration.', ARRAY['hope', 'starfish', 'regeneration', 'inspiration', 'guiding'], ARRAY['lost hope', 'disconnection', 'uninspired']),

(19, 4, 'The Moon: A wolf howling at the moon. Primal instinct, the wild call, illusion and intuition, trusting animal knowing.', 'Fear of instinct, repressed wildness, false intuition.', ARRAY['instinct', 'wolf', 'moon', 'wild', 'howl'], ARRAY['fear', 'repressed', 'false']),

(20, 4, 'The Sun: A sunflower in full bloom. Joy, vitality, turning toward the light, natural radiance and success.', 'Diminished vitality, turning from light, wilted confidence.', ARRAY['joy', 'sunflower', 'vitality', 'light', 'radiance'], ARRAY['diminished', 'wilted', 'darkness']),

(21, 4, 'Judgment: A phoenix rising from flames. Rebirth, awakening, the call to rise renewed from ashes of the past.', 'Refusing rebirth, stuck in ashes, unable to rise.', ARRAY['rebirth', 'phoenix', 'awakening', 'renewal', 'rising'], ARRAY['refusal', 'stuck', 'unable to rise']),

(22, 4, 'The World: A cosmic egg with all elements. Completion, wholeness, the cycle complete, all elements in harmony.', 'Incompletion, missing pieces, imbalanced elements.', ARRAY['completion', 'wholeness', 'cosmic egg', 'harmony', 'unity'], ARRAY['incompletion', 'missing', 'imbalanced']);

-- Sample Minor Arcana for Wild Unknown
-- (You would complete all 56 cards with animal/nature imagery)
INSERT INTO card_meanings (card_id, deck_id, upright_meaning, reversed_meaning, upright_keywords, reversed_keywords) VALUES
(23, 4, 'Ace of Wands: A sprouting branch with leaves. New creative growth, natural passion, the seed of fire taking root in earth.', 'Creative blocks, withered growth, false starts.', ARRAY['growth', 'branch', 'creative', 'sprouting', 'passion'], ARRAY['blocked', 'withered', 'false start']),

(24, 4, 'Two of Wands: Two crossed branches forming balance. Planning with natural wisdom, surveying your territory from a strong foundation.', 'Poor planning, weak foundation, fear of expansion.', ARRAY['planning', 'branches', 'balance', 'territory', 'foundation'], ARRAY['poor planning', 'weak', 'fear']);

-- Continue for remaining cards with nature/animal themes...

-- ============================================
-- 007_add_modern_witch_deck.sql
-- ============================================

-- Add Modern Witch Tarot deck (Lisa Sterle)
INSERT INTO decks (name, description, imagery_style) VALUES
('Modern Witch Tarot', 'Created by Lisa Sterle. A diverse, modern reimagining of the Rider-Waite-Smith deck featuring witchy, contemporary characters in urban settings. Celebrates diversity and modern magical practice.', 'Modern/Urban/Diverse');

-- Card meanings for Modern Witch deck (deck_id = 5)
-- This deck follows RWS structure but with modern, diverse, urban imagery

INSERT INTO card_meanings (card_id, deck_id, upright_meaning, reversed_meaning, upright_keywords, reversed_keywords) VALUES
-- Major Arcana for Modern Witch
(1, 5, 'The Fool: A young witch stepping confidently into new adventures, phone in hand, ready for anything. Modern beginnings with magical mindset.', 'Distraction from path, reckless choices, refusing growth.', ARRAY['new beginnings', 'modern magic', 'adventure', 'confidence', 'risk'], ARRAY['distraction', 'recklessness', 'refusal']),

(2, 5, 'The Magician: A witch at their altar with tools of the craft and technology. Manifesting through intention and modern means, wielding ancient and new power.', 'Trickery, misuse of magic, manipulation, tech overwhelm.', ARRAY['manifestation', 'modern magic', 'tools', 'skill', 'intention'], ARRAY['trickery', 'manipulation', 'overwhelm']),

(3, 5, 'The High Priestess: A mystical figure surrounded by books, crystals, and moonlight. Intuitive wisdom, occult knowledge, trusting inner voice.', 'Ignoring intuition, superficial practice, disconnection from inner knowing.', ARRAY['intuition', 'mystery', 'occult knowledge', 'moonlight', 'wisdom'], ARRAY['ignored intuition', 'superficial', 'disconnection']),

(4, 5, 'The Empress: A lush, abundant witch in creative flow. Feminine power, creation, nurturing your craft and manifestations.', 'Creative blocks, neglect of self-care, empty abundance.', ARRAY['abundance', 'creation', 'feminine power', 'nurturing', 'flow'], ARRAY['blocked', 'neglect', 'empty']),

(5, 5, 'The Emperor: A powerful figure establishing structure in their magical practice. Authority, discipline in craft, building solid foundations.', 'Tyranny, rigidity, harsh discipline, controlling behavior.', ARRAY['authority', 'structure', 'discipline', 'foundation', 'stability'], ARRAY['tyranny', 'rigidity', 'controlling']),

(6, 5, 'The Hierophant: A coven leader teaching ancient wisdom in modern ways. Tradition, mentorship, learning the craft from those who came before.', 'Dogma, false teachers, rejecting all tradition, spiritual bypassing.', ARRAY['tradition', 'teaching', 'mentorship', 'coven', 'wisdom'], ARRAY['dogma', 'false teaching', 'rejection']),

(7, 5, 'The Lovers: Two souls connecting deeply, choices made with heart and head. Love, alignment, choosing partnership consciously.', 'Misalignment, poor relationship choices, disharmony.', ARRAY['love', 'connection', 'choice', 'alignment', 'partnership'], ARRAY['misalignment', 'poor choice', 'disharmony']),

(8, 5, 'The Chariot: A determined witch moving forward with purpose. Victory through will, controlling opposing forces, directed momentum.', 'Lost control, scattered energy, lack of direction.', ARRAY['determination', 'victory', 'control', 'purpose', 'momentum'], ARRAY['lost control', 'scattered', 'directionless']),

(9, 5, 'Strength: A witch gently working with a wild creature. Gentle power, courage, compassionate strength, taming through kindness not force.', 'Weakness, fear, harsh control, lack of compassion.', ARRAY['gentle power', 'courage', 'compassion', 'kindness', 'strength'], ARRAY['weakness', 'harshness', 'fear']),

(10, 5, 'The Hermit: A solitary witch with their lantern in quiet contemplation. Introspection, solitary practice, inner guidance, necessary withdrawal.', 'Isolation, loneliness, refusing guidance, lost in darkness.', ARRAY['introspection', 'solitude', 'inner guidance', 'lantern', 'wisdom'], ARRAY['isolation', 'loneliness', 'lost']),

(11, 5, 'Wheel of Fortune: The cosmic wheel turning, cycles of magic and mundane. Destiny, karma, the ever-turning wheel of the year.', 'Bad luck, resistance to cycles, breaking from natural flow.', ARRAY['destiny', 'cycles', 'karma', 'turning point', 'fortune'], ARRAY['bad luck', 'resistance', 'disrupted']),

(12, 5, 'Justice: A witch with scales, balancing magical ethics. Truth, karma, fair dealings, what you send out returns threefold.', 'Injustice, imbalanced karma, harsh judgment, unfairness.', ARRAY['justice', 'balance', 'truth', 'karma', 'ethics'], ARRAY['injustice', 'imbalance', 'harsh judgment']),

(13, 5, 'The Hanged Man: A witch in meditation, seeing from a new angle. Surrender, pause, gaining perspective through stillness.', 'Unnecessary martyrdom, resistance to pause, stagnation.', ARRAY['surrender', 'new perspective', 'pause', 'meditation', 'letting go'], ARRAY['martyrdom', 'resistance', 'stagnation']),

(14, 5, 'Death: Transformation magic, the necessary ending for rebirth. Shedding old skin, releasing what no longer serves, change.', 'Resisting transformation, clinging to past, fear of change.', ARRAY['transformation', 'endings', 'release', 'rebirth', 'change'], ARRAY['resistance', 'clinging', 'fear']),

(15, 5, 'Temperance: A witch blending potions with patience. Balance, alchemy, mixing energies with care, the middle path.', 'Imbalance, rushed magic, extremes, poor mixing.', ARRAY['balance', 'alchemy', 'patience', 'mixing', 'moderation'], ARRAY['imbalance', 'rushed', 'extremes']),

(16, 5, 'The Devil: A witch enjoying earthly pleasures, chains self-imposed. Shadow work, material pleasures, recognizing bondage.', 'Breaking free from addictions, liberation, released from shadow.', ARRAY['shadow work', 'material pleasures', 'bondage', 'earthly', 'indulgence'], ARRAY['liberation', 'breaking free', 'release']),

(17, 5, 'The Tower: Sudden disruption, magical breakthrough, structures crumbling. Upheaval, revelation, lightning bolt of truth.', 'Avoiding disaster, fear of change, resisting revelation.', ARRAY['upheaval', 'revelation', 'breakthrough', 'disruption', 'truth'], ARRAY['avoidance', 'fear', 'resistance']),

(18, 5, 'The Star: A witch under starlight, hope renewed, healing magic. Inspiration, cosmic connection, spiritual renewal.', 'Lost hope, disconnection from cosmos, lack of inspiration.', ARRAY['hope', 'starlight', 'healing', 'inspiration', 'renewal'], ARRAY['lost hope', 'disconnection', 'despair']),

(19, 5, 'The Moon: A witch navigating by moonlight, intuition and illusion. The mystery of the craft, trusting magical knowing.', 'Fear of magic, deception, confused intuition.', ARRAY['moonlight', 'intuition', 'mystery', 'magic', 'dreams'], ARRAY['fear', 'deception', 'confusion']),

(20, 5, 'The Sun: A witch in full power, radiant and successful. Joy, vitality, magic in full bloom, confidence shining.', 'Diminished power, lack of confidence, clouded success.', ARRAY['joy', 'vitality', 'success', 'radiance', 'confidence'], ARRAY['diminished', 'lack of confidence', 'clouded']),

(21, 5, 'Judgment: A witch answering their calling, spiritual awakening. Higher purpose, absolution, the call to rise and serve.', 'Ignoring calling, harsh self-judgment, refusing to rise.', ARRAY['calling', 'awakening', 'higher purpose', 'absolution', 'rebirth'], ARRAY['ignored calling', 'self-judgment', 'refusal']),

(22, 5, 'The World: A witch having achieved mastery, completion, wholeness. The great work complete, integration, cosmic dance.', 'Incompletion, missing pieces, shortcuts, lack of integration.', ARRAY['completion', 'mastery', 'wholeness', 'achievement', 'integration'], ARRAY['incompletion', 'shortcuts', 'fragmented']);

-- Sample Minor Arcana for Modern Witch
-- (You would complete all 56 cards following RWS structure with modern, diverse imagery)
INSERT INTO card_meanings (card_id, deck_id, upright_meaning, reversed_meaning, upright_keywords, reversed_keywords) VALUES
(23, 5, 'Ace of Wands: A witch holding a magical wand sparking with creative energy. New creative projects, passion, inspired action.', 'Creative blocks, false starts, diminished passion.', ARRAY['creativity', 'passion', 'new project', 'inspiration', 'energy'], ARRAY['blocks', 'false starts', 'diminished']),

(24, 5, 'Two of Wands: A witch planning magical ventures, world in hand. Planning, decisions, stepping out of comfort zone.', 'Fear of unknown, poor planning, indecision.', ARRAY['planning', 'decisions', 'world', 'future', 'boldness'], ARRAY['fear', 'poor planning', 'indecision']),

(37, 5, 'Ace of Cups: A witch receiving an overflowing chalice. New love, emotional beginning, spiritual abundance, open heart.', 'Blocked emotions, closed heart, emotional emptiness.', ARRAY['new love', 'emotions', 'abundance', 'open heart', 'spiritual'], ARRAY['blocked', 'closed', 'emptiness']),

(51, 5, 'Ace of Swords: A witch wielding a sword of truth. Mental clarity, breakthrough, cutting through confusion, honest communication.', 'Confusion, mental blocks, harsh words, clouded judgment.', ARRAY['clarity', 'truth', 'breakthrough', 'communication', 'mind'], ARRAY['confusion', 'blocks', 'harsh']),

(65, 5, 'Ace of Pentacles: A witch receiving a pentacle of abundance. New financial opportunity, manifestation, prosperity, grounding.', 'Lost opportunity, poor planning, missed manifestation.', ARRAY['prosperity', 'opportunity', 'manifestation', 'grounding', 'abundance'], ARRAY['lost opportunity', 'poor planning', 'missed']);

-- Continue for remaining cards with modern, diverse, magical imagery...

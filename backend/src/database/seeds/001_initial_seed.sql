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

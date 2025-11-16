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

-- Example of a few Minor Arcana cards:
INSERT INTO card_meanings (card_id, deck_id, upright_meaning, reversed_meaning, upright_keywords, reversed_keywords) VALUES
-- Ace of Wands (card_id = 23)
(23, 2, 'The root of fire. Pure creative energy, the spark of inspiration, new projects begun with passion.', 'False starts, creative blocks, scattered energy.', ARRAY['inspiration', 'creative spark', 'new project', 'enthusiasm'], ARRAY['false start', 'creative block', 'scattered', 'delays']),

-- Two of Wands (card_id = 24)
(24, 2, 'Dominion. Planning and personal power. Standing between two staffs, surveying the domain.', 'Fear of unknown, lack of planning, poor decisions.', ARRAY['planning', 'personal power', 'bold decisions'], ARRAY['fear', 'poor planning', 'indecision']);

-- You would continue for all remaining cards...
-- For now, this gives you the structure to work with

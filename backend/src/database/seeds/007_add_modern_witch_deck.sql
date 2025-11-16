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

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

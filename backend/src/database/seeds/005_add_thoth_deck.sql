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

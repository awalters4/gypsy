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

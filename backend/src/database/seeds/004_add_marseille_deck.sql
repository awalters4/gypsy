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

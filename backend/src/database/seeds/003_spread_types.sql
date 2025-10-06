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

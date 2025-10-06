# Tarot Reader

An AI-powered tarot reading application that learns from user feedback to provide increasingly accurate and resonant interpretations.

## Features

- **Manual Card Input**: Users input the cards they've drawn from their physical deck
- **Multiple Spread Types**: Support for various spreads (Single Card, 3-Card, Celtic Cross, etc.)
- **Deck-Specific Meanings**: Store and use different interpretations for different tarot decks
- **AI-Powered Interpretations**: Uses Claude AI to generate personalized, contextual readings
- **Learning System**: Improves over time based on user feedback
- **Image Support**: Upload and display card images for visual reference

## Tech Stack

### Backend
- Node.js + Express + TypeScript
- PostgreSQL database
- Anthropic Claude API for interpretations

### Frontend
- React + TypeScript
- Vite for development
- (To be enhanced with UI library)

## Setup Instructions

### Prerequisites
- Node.js 18+
- PostgreSQL 14+
- Anthropic API key

### Database Setup

1. Create a PostgreSQL database:
```bash
createdb tarot_reader
```

2. Run the schema:
```bash
psql tarot_reader < backend/src/database/schema.sql
```

3. Seed the database:
```bash
psql tarot_reader < backend/src/database/seeds/001_initial_seed.sql
psql tarot_reader < backend/src/database/seeds/002_card_meanings.sql
psql tarot_reader < backend/src/database/seeds/003_spread_types.sql
```

### Backend Setup

1. Navigate to backend directory:
```bash
cd backend
```

2. Create `.env` file:
```bash
cp .env.example .env
```

3. Edit `.env` and add your credentials:
```
PORT=3001
DATABASE_URL=postgresql://localhost:5432/tarot_reader
ANTHROPIC_API_KEY=your_api_key_here
NODE_ENV=development
```

4. Start the development server:
```bash
npm run dev
```

The API will be available at `http://localhost:3001`

### Frontend Setup

1. Navigate to frontend directory:
```bash
cd frontend
```

2. Start the development server:
```bash
npm run dev
```

The app will be available at `http://localhost:5173`

## API Endpoints

### Cards
- `GET /api/cards` - Get all cards (optionally filter by deckId)
- `GET /api/cards/:id` - Get specific card details

### Decks
- `GET /api/decks` - Get all decks
- `GET /api/decks/:id` - Get specific deck

### Spreads
- `GET /api/spreads` - Get all spread types
- `GET /api/spreads/:id` - Get specific spread type

### Readings
- `GET /api/readings` - Get all readings
- `POST /api/readings` - Create a new reading
- `GET /api/readings/:id` - Get specific reading
- `POST /api/readings/:id/feedback` - Submit feedback for a reading

### Interpretation
- `POST /api/interpret` - Generate AI interpretation for cards
  ```json
  {
    "spreadTypeId": 1,
    "deckId": 1,
    "question": "What should I focus on today?",
    "cardsDrawn": [
      {"cardId": 1, "position": 1, "reversed": false}
    ]
  }
  ```

## Database Schema

- `decks` - Tarot deck information
- `cards` - Individual card data (deck-agnostic)
- `card_meanings` - Deck-specific card interpretations
- `card_images` - URLs to card images
- `spread_types` - Different reading layouts
- `users` - User accounts (optional)
- `readings` - Stored reading sessions
- `reading_feedback` - User feedback for learning

## Development Roadmap

### Phase 1 (Current - Week 1)
- [x] Project setup
- [x] Database schema
- [x] Basic API routes
- [x] Seed data for Rider-Waite deck
- [ ] Basic frontend UI

### Phase 2 (Week 2-3)
- [ ] Card input form
- [ ] Spread selection
- [ ] Reading generation
- [ ] Display interpretations

### Phase 3 (Week 4)
- [ ] Feedback system
- [ ] Reading history
- [ ] User authentication

### Phase 4 (Week 5)
- [ ] Multiple deck support
- [ ] Image uploads (Cloudflare R2/Imgur)
- [ ] Deck management UI

### Phase 6 (Week 6)
- [ ] Enhanced learning algorithm
- [ ] Analytics dashboard
- [ ] Deployment

## Future Enhancements

- Reversed card interpretations
- Daily card notifications
- Reading journal
- Export readings as PDF
- Share readings with friends
- Mobile app version

## License

MIT

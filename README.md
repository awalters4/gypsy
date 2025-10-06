# Gypsy - Tarot Reading Application

A full-stack web application for AI-powered tarot card readings. Gypsy provides personalized tarot interpretations using advanced AI, supporting both random card draws and manual selection with physical card image uploads.

## Overview

Gypsy is a complete tarot reading platform that combines traditional tarot wisdom with modern AI technology. Users can perform readings using various spread types, receive AI-generated interpretations, and track their reading history.

## Features

### Reading Modes
- **Random Draw Mode**: Automatically draws random cards from the selected tarot deck
- **Custom Reading Mode**: Input your own card readings
  - Type in card names (one per line) from your physical deck
  - Indicate reversed cards by adding "(reversed)" after the card name
  - Upload a single photo of your entire card spread for visual reference
  - Perfect for users who prefer traditional card readings with AI-powered interpretation

### Core Features
- **Multiple Spread Types**: Support for various spreads including:
  - Single Card readings
  - 3-Card spreads (Past, Present, Future)
  - Celtic Cross
  - And more custom spread configurations
- **Deck Support**: Currently includes the Rider-Waite tarot deck with full card meanings
- **AI-Powered Interpretations**: Contextual, personalized readings based on:
  - Selected cards and positions
  - Card orientation (upright/reversed)
  - User's question or intention
  - Spread-specific position meanings
- **Reading History**: All readings are stored in the database for future reference
- **Feedback System**: Rate and provide feedback on readings for quality tracking

## Tech Stack

### Backend
- **Runtime**: Node.js with Express framework
- **Language**: TypeScript for type safety
- **Database**: PostgreSQL 14+ with full schema and seed data
- **AI Integration**: Anthropic API for natural language interpretation generation
- **Architecture**: RESTful API design with proper error handling and CORS support

### Frontend
- **Framework**: React 19+ with TypeScript
- **Build Tool**: Vite for fast development and optimized builds
- **Styling**: Custom CSS with dark theme and responsive design
- **State Management**: React hooks (useState, useEffect)
- **File Handling**: Native FileReader API for image uploads

### Development
- **Backend Dev Server**: Nodemon with tsx for hot reload
- **Frontend Dev Server**: Vite dev server with HMR (Hot Module Replacement)
- **Type Checking**: TypeScript strict mode across both frontend and backend

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

2. Install dependencies:
```bash
npm install
```

3. Start the development server:
```bash
npm run dev
```

The app will be available at `http://localhost:5174` (or next available port)

## How to Use

### Performing a Reading

#### Random Draw Mode (Default)
1. Open the application in your browser
2. Select a tarot deck from the dropdown (currently Rider-Waite)
3. Choose a spread type (e.g., 3-Card, Celtic Cross)
4. Optionally, enter a question or intention for the reading
5. Click "Draw Cards" to randomly select cards
6. Review the drawn cards with their positions and meanings
7. Click "Get Interpretation" to receive an AI-generated reading
8. Read your personalized interpretation
9. Click "New Reading" to start fresh

#### Custom Reading Mode
1. Click the "Custom Reading" button at the top
2. Select a tarot deck (optional - helps with card matching)
3. Type your cards in the text area, one per line:
   ```
   The Fool
   The Magician (reversed)
   The High Priestess
   ```
4. Optionally upload a photo of your entire card spread
5. Click "Submit Reading"
6. Review your cards with their meanings
7. Click "Get Interpretation" for your AI-powered reading
8. View the interpretation alongside your uploaded spread photo

**Card Input Format:**
- Enter card names exactly as they appear (e.g., "The Fool", "Ace of Cups")
- Add "(reversed)" or "- reversed" after the card name for reversed cards
- One card per line
- The app will automatically match card names from the database

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

## Project Status

### Completed Features ✅
- Full-stack application setup (React + Node.js + PostgreSQL)
- Complete database schema with seed data
- Rider-Waite tarot deck with all 78 cards and meanings
- Multiple spread types (Single Card, 3-Card, Celtic Cross, etc.)
- Random card draw functionality
- Custom reading input mode (text-based card entry)
- Single spread photo upload capability
- AI-powered interpretation generation
- Intelligent card name parsing (handles reversed notation)
- Reading storage and history
- Feedback system foundation
- Responsive dark-themed UI
- TypeScript across frontend and backend
- RESTful API with full CRUD operations

### In Progress 🚧
- Enhanced learning algorithm based on feedback data
- User authentication and accounts
- Reading journal features

### Planned Features 📋
- Additional tarot deck support (add your own decks)
- Daily card notifications/reminders
- Export readings as PDF
- Social sharing capabilities
- Analytics dashboard for reading patterns
- Mobile-responsive improvements
- Deck management UI for adding custom decks
- Card image hosting integration
- Advanced filtering for reading history

## Project Structure

```
tarot-reader/
├── backend/
│   ├── src/
│   │   ├── database/
│   │   │   ├── schema.sql          # Database schema
│   │   │   ├── db.ts               # Database connection
│   │   │   └── seeds/              # Seed data files
│   │   ├── routes/                 # API route handlers
│   │   │   ├── cards.ts
│   │   │   ├── decks.ts
│   │   │   ├── spreads.ts
│   │   │   ├── readings.ts
│   │   │   └── interpret.ts
│   │   ├── services/
│   │   │   └── interpretationService.ts  # AI integration
│   │   └── index.ts                # Express app entry
│   ├── package.json
│   └── tsconfig.json
│
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   │   └── TarotReading.tsx    # Main reading component
│   │   ├── services/
│   │   │   └── api.ts              # API client
│   │   ├── types/
│   │   │   └── index.ts            # TypeScript interfaces
│   │   ├── App.tsx
│   │   ├── App.css
│   │   └── main.tsx
│   ├── package.json
│   └── vite.config.ts
│
└── README.md
```

## License

MIT

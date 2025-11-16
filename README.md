# Gypsy - AI-Powered Tarot Reading Platform

A modern, full-stack tarot reading application with advanced AI interpretations. Supports both web-based readings and will soon include a native mobile app.

## 🎴 What is Gypsy?

Gypsy combines traditional tarot wisdom with cutting-edge AI technology to provide personalized, insightful tarot readings. Whether you're drawing cards digitally or reading from a physical deck, Gypsy offers intelligent interpretations powered by Claude AI.

## ✨ Key Features

### AI-Powered Interpretations
- **Streaming Responses**: Real-time AI interpretation generation with smooth streaming
- **Tone Preferences**: Choose from warm, direct, mystical, or analytical reading styles
- **Question Refinement**: AI helps you craft better, more focused questions
- **Follow-Up Questions**: Continue the conversation with context-aware follow-ups
- **Card Explanations**: Click any card for detailed symbolism and meaning
- **Context Preview**: See what information the AI will use before generating interpretations

### Multiple Reading Modes
- **Random Draw**: Let the cards choose themselves
- **Custom Reading**: Input cards from your physical deck
- **Photo Upload**: Capture your card spread for reference

### Multiple Decks
- Rider-Waite (Traditional)
- Marseille Tarot (Classic French)
- Thoth Tarot (Crowley's Occult Deck)
- Wild Unknown (Nature & Animals)
- Modern Witch (Contemporary Urban)

### Spread Types
- Single Card
- 3-Card (Past, Present, Future)
- Celtic Cross
- And more custom spreads

## 🏗️ Project Structure

This is a **monorepo** containing:

```
gypsy/
├── backend/          # Express API server (Node.js + TypeScript)
├── frontend/         # React web app (Vite + TypeScript)
├── vercel.json       # Frontend deployment config
└── DEPLOYMENT.md     # Deployment instructions
```

**Related Projects:**
- **gypsy-mobile** (Coming Soon) - React Native mobile app

## 🚀 Quick Start

### Prerequisites
- Node.js 18+
- PostgreSQL 14+
- Anthropic API key ([Get one here](https://console.anthropic.com))

### Backend Setup

```bash
cd backend
npm install
cp .env.example .env
# Edit .env with your credentials
npm run dev
```

### Frontend Setup

```bash
cd frontend
npm install
npm run dev
```

Visit `http://localhost:5173` to see the app!

## 📖 Full Documentation

- **[DEPLOYMENT.md](./DEPLOYMENT.md)** - Complete deployment guide for Vercel
- **[Backend README](./backend/README.md)** - API documentation
- **[Frontend README](./frontend/README.md)** - UI component documentation

## 🎯 API Endpoints

### Core Endpoints
- `GET /api/decks` - List all tarot decks
- `GET /api/spreads` - List all spread types
- `POST /api/readings` - Create a new reading
- `POST /api/interpret/stream` - Get streaming AI interpretation

### AI Features
- `POST /api/interpret/refine-question` - Improve your question
- `POST /api/interpret/follow-up` - Ask follow-up questions
- `POST /api/interpret/explain-card` - Get card-specific insights
- `GET /api/interpret/context` - Preview AI context

### Deck Management
- `POST /api/decks` - Create custom deck
- `POST /api/decks/:id/card-meanings/bulk` - Upload card meanings
- Full CRUD for decks and card meanings

## 🛠️ Tech Stack

**Backend:**
- Node.js + Express
- TypeScript
- PostgreSQL
- Anthropic Claude API
- Server-Sent Events (SSE) for streaming

**Frontend:**
- React 19
- TypeScript
- Vite
- Custom CSS with animations

**Deployment:**
- Vercel (Frontend + Backend)
- Vercel Postgres (Database)

## 📱 Mobile App (Coming Soon)

A React Native version is in development at **well-walt-studios/gypsy-mobile**

## 🤝 Contributing

This is a personal project, but feedback and suggestions are welcome!

## 📄 License

MIT

import express, { Express, Request, Response } from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import cardsRouter from './routes/cards';
import decksRouter from './routes/decks';
import spreadsRouter from './routes/spreads';
import readingsRouter from './routes/readings';
import interpretRouter from './routes/interpret';

dotenv.config();

// Validate required environment variables
if (!process.env.ANTHROPIC_API_KEY) {
  console.error('❌ Error: ANTHROPIC_API_KEY environment variable is required');
  console.error('Please set ANTHROPIC_API_KEY in your .env file');
  process.exit(1);
}

const app: Express = express();
const port = process.env.PORT || 3001;

// Configure CORS
const allowedOrigins = process.env.ALLOWED_ORIGINS
  ? process.env.ALLOWED_ORIGINS.split(',')
  : ['http://localhost:5173', 'http://localhost:3000'];

app.use(cors({
  origin: (origin, callback) => {
    // Allow requests with no origin (like mobile apps or curl requests)
    if (!origin) return callback(null, true);

    if (allowedOrigins.includes(origin)) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  },
  credentials: true
}));

app.use(express.json());

app.get('/health', (req: Request, res: Response) => {
  res.json({ status: 'ok', message: 'Tarot Reader API is running' });
});

// API routes
app.use('/api/cards', cardsRouter);
app.use('/api/decks', decksRouter);
app.use('/api/spreads', spreadsRouter);
app.use('/api/readings', readingsRouter);
app.use('/api/interpret', interpretRouter);

app.listen(port, () => {
  console.log(`⚡️ Server is running at http://localhost:${port}`);
});

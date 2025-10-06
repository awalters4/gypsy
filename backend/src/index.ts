import express, { Express, Request, Response } from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import cardsRouter from './routes/cards';
import decksRouter from './routes/decks';
import spreadsRouter from './routes/spreads';
import readingsRouter from './routes/readings';
import interpretRouter from './routes/interpret';

dotenv.config();

const app: Express = express();
const port = process.env.PORT || 3001;

app.use(cors());
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

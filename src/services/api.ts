import axios, { AxiosInstance } from 'axios';
import {
  Deck,
  Card,
  SpreadType,
  Reading,
  InterpretationRequest,
  CardInReading,
  TonePreference,
  QuestionRefinement,
  FollowUpResponse,
  CardExplanation,
} from '../types';

// Configure your API base URL here
// For local development: 'http://localhost:3001/api'
// For production: 'https://tarot-reader.vercel.app/api'
const API_BASE_URL = __DEV__
  ? 'http://localhost:3001/api'  // Change to your local IP if testing on physical device
  : 'https://tarot-reader.vercel.app/api';

class GypsyAPI {
  private client: AxiosInstance;

  constructor() {
    this.client = axios.create({
      baseURL: API_BASE_URL,
      headers: {
        'Content-Type': 'application/json',
      },
      timeout: 30000, // 30 seconds
    });
  }

  // Decks
  async getDecks(): Promise<Deck[]> {
    const response = await this.client.get('/decks');
    return response.data;
  }

  async getDeck(id: number): Promise<Deck> {
    const response = await this.client.get(`/decks/${id}`);
    return response.data;
  }

  // Cards
  async getCards(deckId?: number): Promise<Card[]> {
    const response = await this.client.get('/cards', {
      params: deckId ? { deckId } : undefined,
    });
    return response.data;
  }

  async getCard(id: number): Promise<Card> {
    const response = await this.client.get(`/cards/${id}`);
    return response.data;
  }

  // Spreads
  async getSpreads(): Promise<SpreadType[]> {
    const response = await this.client.get('/spreads');
    return response.data;
  }

  async getSpread(id: number): Promise<SpreadType> {
    const response = await this.client.get(`/spreads/${id}`);
    return response.data;
  }

  // Readings
  async createReading(reading: Reading): Promise<Reading> {
    const response = await this.client.post('/readings', reading);
    return response.data;
  }

  async getReadings(): Promise<Reading[]> {
    const response = await this.client.get('/readings');
    return response.data;
  }

  async getReading(id: number): Promise<Reading> {
    const response = await this.client.get(`/readings/${id}`);
    return response.data;
  }

  // AI Interpretation (Non-streaming version for mobile)
  async getInterpretation(request: InterpretationRequest): Promise<string> {
    const response = await this.client.post('/interpret', request);
    return response.data.interpretation;
  }

  // Question Refinement
  async refineQuestion(
    question: string,
    spreadType: string
  ): Promise<QuestionRefinement> {
    const response = await this.client.post('/interpret/refine-question', {
      question,
      spreadType,
    });
    return response.data;
  }

  // Follow-up Questions
  async askFollowUp(
    question: string,
    originalInterpretation: string,
    cardsDrawn: CardInReading[]
  ): Promise<FollowUpResponse> {
    const response = await this.client.post('/interpret/follow-up', {
      question,
      originalInterpretation,
      cardsDrawn,
    });
    return response.data;
  }

  // Card Explanation
  async explainCard(
    cardId: number,
    deckId: number,
    reversed: boolean,
    context?: string
  ): Promise<CardExplanation> {
    const response = await this.client.post('/interpret/explain-card', {
      cardId,
      deckId,
      reversed,
      context,
    });
    return response.data;
  }

  // Draw random cards
  async drawRandomCards(
    deckId: number,
    count: number
  ): Promise<Card[]> {
    const allCards = await this.getCards(deckId);

    // Shuffle and pick random cards
    const shuffled = [...allCards].sort(() => Math.random() - 0.5);
    return shuffled.slice(0, count);
  }
}

export const gypsyAPI = new GypsyAPI();
export default gypsyAPI;

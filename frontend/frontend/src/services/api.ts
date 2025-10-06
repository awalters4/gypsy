import {
  Card,
  Deck,
  SpreadType,
  Reading,
  InterpretationRequest,
  InterpretationResponse,
} from '../types';

const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:3001/api';

export const api = {
  // Decks
  async getDecks(): Promise<Deck[]> {
    const response = await fetch(`${API_BASE_URL}/decks`);
    if (!response.ok) throw new Error('Failed to fetch decks');
    return response.json();
  },

  async getDeck(id: number): Promise<Deck> {
    const response = await fetch(`${API_BASE_URL}/decks/${id}`);
    if (!response.ok) throw new Error('Failed to fetch deck');
    return response.json();
  },

  // Spreads
  async getSpreads(): Promise<SpreadType[]> {
    const response = await fetch(`${API_BASE_URL}/spreads`);
    if (!response.ok) throw new Error('Failed to fetch spreads');
    return response.json();
  },

  async getSpread(id: number): Promise<SpreadType> {
    const response = await fetch(`${API_BASE_URL}/spreads/${id}`);
    if (!response.ok) throw new Error('Failed to fetch spread');
    return response.json();
  },

  // Cards
  async getCards(deckId?: number): Promise<Card[]> {
    const url = deckId
      ? `${API_BASE_URL}/cards?deckId=${deckId}`
      : `${API_BASE_URL}/cards`;
    const response = await fetch(url);
    if (!response.ok) throw new Error('Failed to fetch cards');
    return response.json();
  },

  async getCard(id: number): Promise<Card> {
    const response = await fetch(`${API_BASE_URL}/cards/${id}`);
    if (!response.ok) throw new Error('Failed to fetch card');
    return response.json();
  },

  // Readings
  async getReadings(): Promise<Reading[]> {
    const response = await fetch(`${API_BASE_URL}/readings`);
    if (!response.ok) throw new Error('Failed to fetch readings');
    return response.json();
  },

  async getReading(id: number): Promise<Reading> {
    const response = await fetch(`${API_BASE_URL}/readings/${id}`);
    if (!response.ok) throw new Error('Failed to fetch reading');
    return response.json();
  },

  // Interpretation
  async generateInterpretation(
    request: InterpretationRequest
  ): Promise<InterpretationResponse> {
    const response = await fetch(`${API_BASE_URL}/interpret`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(request),
    });
    if (!response.ok) throw new Error('Failed to generate interpretation');
    return response.json();
  },
};

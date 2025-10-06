export interface Card {
  id: number;
  name: string;
  suit: string | null;
  number: number | null;
  arcana: string;
  upright_meaning: string;
  reversed_meaning: string;
  keywords: string[];
  image_url: string | null;
  deck_id: number;
}

export interface Deck {
  id: number;
  name: string;
  description: string | null;
  theme: string | null;
  created_at: string;
}

export interface SpreadType {
  id: number;
  name: string;
  description: string | null;
  position_count: number;
  positions: Record<string, string>;
  created_at: string;
}

export interface Reading {
  id: number;
  user_id: number | null;
  spread_type_id: number;
  deck_id: number;
  question: string | null;
  cards_drawn: DrawnCard[];
  interpretation: string;
  created_at: string;
}

export interface DrawnCard {
  cardId: number;
  position: number;
  reversed: boolean;
}

export interface InterpretationRequest {
  userId?: number;
  spreadTypeId: number;
  deckId: number;
  question?: string;
  cardsDrawn: DrawnCard[];
}

export interface InterpretationResponse {
  reading: Reading;
  interpretation: string;
}

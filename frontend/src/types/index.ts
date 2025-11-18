export interface Card {
  id: number;
  name: string;
  suit: string | null;
  number: number | null;
  arcana: string;
  upright_meaning: string;
  reversed_meaning: string;
  upright_keywords: string[];
  reversed_keywords: string[];
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
  tone?: TonePreference;
}

export interface InterpretationResponse {
  reading: Reading;
  interpretation: string;
}

export type TonePreference = 'warm' | 'direct' | 'mystical' | 'analytical';

export interface CardContext {
  position: string;
  positionMeaning: string;
  card: string;
  reversed: boolean;
  meaning: string;
  keywords: string[];
}

export interface AIContextPreview {
  spread: {
    name: string;
    description: string | null;
  };
  cards: CardContext[];
  pastReadingsCount: number;
}

export interface QuestionRefinement {
  original: string;
  refined: string;
}

export interface FollowUpResponse {
  answer: string;
}

export interface CardExplanation {
  explanation: string;
  card: CardContext;
}

// Deck management types
export interface DeckCreate {
  name: string;
  description?: string;
  imagery_style?: string;
}

export interface DeckUpdate {
  name: string;
  description?: string;
  imagery_style?: string;
}

export interface CardMeaningBulk {
  cardId: number;
  uprightMeaning: string;
  reversedMeaning?: string;
  uprightKeywords?: string[];
  reversedKeywords?: string[];
}

export interface CardMeaningUpdate {
  uprightMeaning: string;
  reversedMeaning?: string;
  uprightKeywords?: string[];
  reversedKeywords?: string[];
}

export interface BulkUploadResponse {
  message: string;
  cardMeanings: any[];
}

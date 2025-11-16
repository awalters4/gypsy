// Core Types for Gypsy Mobile App

export interface Deck {
  id: number;
  name: string;
  description?: string;
  imagery_style?: string;
  created_at?: string;
}

export interface Card {
  id: number;
  name: string;
  number?: number;
  suit?: string;
  card_type?: string;
  archetype?: string;
}

export interface CardMeaning {
  id: number;
  card_id: number;
  deck_id: number;
  upright_meaning: string;
  reversed_meaning?: string;
  upright_keywords?: string[];
  reversed_keywords?: string[];
}

export interface SpreadPosition {
  position: number;
  name: string;
  meaning: string;
}

export interface SpreadType {
  id: number;
  name: string;
  description?: string;
  position_count: number;
  positions: SpreadPosition[];
}

export interface CardInReading {
  cardId: number;
  position: number;
  reversed: boolean;
}

export interface Reading {
  id?: number;
  user_id?: number;
  spread_type_id: number;
  deck_id: number;
  question?: string;
  cards_drawn: CardInReading[];
  interpretation?: string;
  photo_url?: string;
  created_at?: string;
}

export type TonePreference = 'warm' | 'direct' | 'mystical' | 'analytical';

export interface InterpretationRequest {
  spreadTypeId: number;
  deckId: number;
  cardsDrawn: CardInReading[];
  question?: string;
  tone?: TonePreference;
}

export interface CardDetail {
  card: Card;
  meaning: CardMeaning;
  position?: string;
  position_meaning?: string;
  reversed: boolean;
}

export interface QuestionRefinement {
  originalQuestion: string;
  refinedQuestion: string;
  improvements: string[];
}

export interface FollowUpResponse {
  answer: string;
  relatedCards?: string[];
}

export interface CardExplanation {
  cardName: string;
  symbolism: string;
  generalMeaning: string;
  inThisReading: string;
}

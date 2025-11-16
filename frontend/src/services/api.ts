import type {
  Card,
  Deck,
  SpreadType,
  Reading,
  InterpretationRequest,
  InterpretationResponse,
  AIContextPreview,
  QuestionRefinement,
  FollowUpResponse,
  CardExplanation,
  DrawnCard,
} from '../types/index';

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

  // Interpretation - non-streaming (backward compatible)
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
    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to generate interpretation');
    }
    return response.json();
  },

  // Streaming interpretation
  async generateStreamingInterpretation(
    request: InterpretationRequest,
    onChunk: (chunk: string) => void,
    onComplete: (readingId: number) => void,
    onError: (error: string) => void
  ): Promise<void> {
    const response = await fetch(`${API_BASE_URL}/interpret/stream`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(request),
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to generate interpretation');
    }

    const reader = response.body?.getReader();
    const decoder = new TextDecoder();

    if (!reader) {
      throw new Error('Response body is not readable');
    }

    try {
      while (true) {
        const { done, value } = await reader.read();
        if (done) break;

        const chunk = decoder.decode(value);
        const lines = chunk.split('\n');

        for (const line of lines) {
          if (line.startsWith('data: ')) {
            const data = JSON.parse(line.slice(6));

            if (data.error) {
              onError(data.error);
              return;
            }

            if (data.done) {
              onComplete(data.readingId);
              return;
            }

            if (data.chunk) {
              onChunk(data.chunk);
            }
          }
        }
      }
    } catch (error) {
      onError(error instanceof Error ? error.message : 'Streaming error');
    }
  },

  // Get AI context preview
  async getAIContext(
    spreadTypeId: number,
    deckId: number,
    cardsDrawn: DrawnCard[]
  ): Promise<AIContextPreview> {
    const response = await fetch(`${API_BASE_URL}/interpret/context`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ spreadTypeId, deckId, cardsDrawn }),
    });
    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to fetch AI context');
    }
    return response.json();
  },

  // Refine question with AI
  async refineQuestion(question: string): Promise<QuestionRefinement> {
    const response = await fetch(`${API_BASE_URL}/interpret/refine-question`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ question }),
    });
    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to refine question');
    }
    return response.json();
  },

  // Ask follow-up question
  async askFollowUp(
    readingId: number,
    followUpQuestion: string
  ): Promise<FollowUpResponse> {
    const response = await fetch(`${API_BASE_URL}/interpret/follow-up`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ readingId, followUpQuestion }),
    });
    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to answer follow-up question');
    }
    return response.json();
  },

  // Explain specific card
  async explainCard(
    readingId: number,
    cardPosition: number
  ): Promise<CardExplanation> {
    const response = await fetch(`${API_BASE_URL}/interpret/explain-card`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ readingId, cardPosition }),
    });
    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to explain card');
    }
    return response.json();
  },
};

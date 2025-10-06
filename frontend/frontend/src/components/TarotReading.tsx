import { useState, useEffect } from 'react';
import { api } from '../services/api';
import {
  Deck,
  SpreadType,
  Card,
  DrawnCard,
  InterpretationResponse,
} from '../types/index';

export default function TarotReading() {
  const [decks, setDecks] = useState<Deck[]>([]);
  const [spreads, setSpreads] = useState<SpreadType[]>([]);
  const [cards, setCards] = useState<Card[]>([]);
  const [selectedDeck, setSelectedDeck] = useState<number | null>(null);
  const [selectedSpread, setSelectedSpread] = useState<number | null>(null);
  const [question, setQuestion] = useState('');
  const [drawnCards, setDrawnCards] = useState<DrawnCard[]>([]);
  const [result, setResult] = useState<InterpretationResponse | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const loadData = async () => {
      try {
        const [decksData, spreadsData] = await Promise.all([
          api.getDecks(),
          api.getSpreads(),
        ]);
        setDecks(decksData);
        setSpreads(spreadsData);
      } catch (err) {
        setError('Failed to load decks and spreads');
        console.error(err);
      }
    };
    loadData();
  }, []);

  useEffect(() => {
    if (selectedDeck) {
      const loadCards = async () => {
        try {
          const cardsData = await api.getCards(selectedDeck);
          setCards(cardsData);
        } catch (err) {
          setError('Failed to load cards');
          console.error(err);
        }
      };
      loadCards();
    }
  }, [selectedDeck]);

  const drawCards = () => {
    if (!selectedSpread || !selectedDeck || cards.length === 0) {
      setError('Please select a deck and spread type');
      return;
    }

    const spread = spreads.find((s) => s.id === selectedSpread);
    if (!spread) return;

    const shuffled = [...cards].sort(() => Math.random() - 0.5);
    const drawn: DrawnCard[] = shuffled.slice(0, spread.num_cards).map((card, index) => ({
      cardId: card.id,
      position: index + 1,
      reversed: Math.random() > 0.5,
    }));

    setDrawnCards(drawn);
    setResult(null);
    setError(null);
  };

  const getInterpretation = async () => {
    if (!selectedDeck || !selectedSpread || drawnCards.length === 0) {
      setError('Please draw cards first');
      return;
    }

    setLoading(true);
    setError(null);

    try {
      const response = await api.generateInterpretation({
        spreadTypeId: selectedSpread,
        deckId: selectedDeck,
        question: question || undefined,
        cardsDrawn: drawnCards,
      });
      setResult(response);
    } catch (err) {
      setError('Failed to generate interpretation');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const resetReading = () => {
    setDrawnCards([]);
    setResult(null);
    setQuestion('');
    setError(null);
  };

  const getCardById = (cardId: number): Card | undefined => {
    return cards.find((c) => c.id === cardId);
  };

  return (
    <div className="tarot-reading">
      <h1>Tarot Reading</h1>

      {error && <div className="error">{error}</div>}

      <div className="settings">
        <div className="form-group">
          <label htmlFor="deck">Select Deck:</label>
          <select
            id="deck"
            value={selectedDeck || ''}
            onChange={(e) => setSelectedDeck(Number(e.target.value))}
            disabled={loading}
          >
            <option value="">Choose a deck...</option>
            {decks.map((deck) => (
              <option key={deck.id} value={deck.id}>
                {deck.name}
              </option>
            ))}
          </select>
        </div>

        <div className="form-group">
          <label htmlFor="spread">Select Spread:</label>
          <select
            id="spread"
            value={selectedSpread || ''}
            onChange={(e) => setSelectedSpread(Number(e.target.value))}
            disabled={loading}
          >
            <option value="">Choose a spread...</option>
            {spreads.map((spread) => (
              <option key={spread.id} value={spread.id}>
                {spread.name} ({spread.num_cards} cards)
              </option>
            ))}
          </select>
        </div>

        <div className="form-group">
          <label htmlFor="question">Your Question (optional):</label>
          <input
            id="question"
            type="text"
            value={question}
            onChange={(e) => setQuestion(e.target.value)}
            placeholder="What would you like guidance on?"
            disabled={loading}
          />
        </div>

        <div className="actions">
          <button
            onClick={drawCards}
            disabled={!selectedDeck || !selectedSpread || loading}
          >
            Draw Cards
          </button>
          {drawnCards.length > 0 && !result && (
            <button onClick={getInterpretation} disabled={loading}>
              {loading ? 'Generating...' : 'Get Interpretation'}
            </button>
          )}
          {(drawnCards.length > 0 || result) && (
            <button onClick={resetReading} disabled={loading}>
              New Reading
            </button>
          )}
        </div>
      </div>

      {drawnCards.length > 0 && (
        <div className="drawn-cards">
          <h2>Your Cards</h2>
          <div className="cards-grid">
            {drawnCards.map((drawnCard) => {
              const card = getCardById(drawnCard.cardId);
              if (!card) return null;
              return (
                <div
                  key={`${drawnCard.cardId}-${drawnCard.position}`}
                  className={`card ${drawnCard.reversed ? 'reversed' : ''}`}
                >
                  <div className="card-position">Position {drawnCard.position}</div>
                  <h3>{card.name}</h3>
                  <p className="card-orientation">
                    {drawnCard.reversed ? 'Reversed' : 'Upright'}
                  </p>
                  <p className="card-meaning">
                    {drawnCard.reversed
                      ? card.reversed_meaning
                      : card.upright_meaning}
                  </p>
                </div>
              );
            })}
          </div>
        </div>
      )}

      {result && (
        <div className="interpretation">
          <h2>Interpretation</h2>
          <div className="interpretation-text">{result.interpretation}</div>
        </div>
      )}
    </div>
  );
}

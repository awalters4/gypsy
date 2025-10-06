import { useState, useEffect } from 'react';
import { api } from '../services/api';
import type {
  Deck,
  SpreadType,
  Card,
  DrawnCard,
  InterpretationResponse,
} from '../types/index';

const COOLDOWN_MINUTES = 5; // Cooldown period in minutes

export default function TarotReading() {
  const [mode, setMode] = useState<'random' | 'custom'>('random');
  const [decks, setDecks] = useState<Deck[]>([]);
  const [spreads, setSpreads] = useState<SpreadType[]>([]);
  const [cards, setCards] = useState<Card[]>([]);
  const [selectedDeck, setSelectedDeck] = useState<number | null>(null);
  const [selectedSpread, setSelectedSpread] = useState<number | null>(null);
  const [question, setQuestion] = useState('');
  const [drawnCards, setDrawnCards] = useState<DrawnCard[]>([]);
  const [customCardInput, setCustomCardInput] = useState('');
  const [spreadImage, setSpreadImage] = useState<string>('');
  const [result, setResult] = useState<InterpretationResponse | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [cooldownUntil, setCooldownUntil] = useState<number | null>(null);
  const [timeRemaining, setTimeRemaining] = useState<string>('');

  // Load initial data
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

    // Check for existing cooldown in localStorage
    const savedCooldown = localStorage.getItem('tarotCooldown');
    if (savedCooldown) {
      const cooldownTime = parseInt(savedCooldown);
      if (cooldownTime > Date.now()) {
        setCooldownUntil(cooldownTime);
      } else {
        localStorage.removeItem('tarotCooldown');
      }
    }
  }, []);

  // Update cooldown timer
  useEffect(() => {
    if (!cooldownUntil) {
      setTimeRemaining('');
      return;
    }

    const updateTimer = () => {
      const now = Date.now();
      const diff = cooldownUntil - now;

      if (diff <= 0) {
        setCooldownUntil(null);
        localStorage.removeItem('tarotCooldown');
        setTimeRemaining('');
      } else {
        const minutes = Math.floor(diff / 60000);
        const seconds = Math.floor((diff % 60000) / 1000);
        setTimeRemaining(`${minutes}:${seconds.toString().padStart(2, '0')}`);
      }
    };

    updateTimer();
    const interval = setInterval(updateTimer, 1000);
    return () => clearInterval(interval);
  }, [cooldownUntil]);

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
    const drawn: DrawnCard[] = shuffled.slice(0, spread.position_count).map((card, index) => ({
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

    if (cooldownUntil && cooldownUntil > Date.now()) {
      setError(`Please wait ${timeRemaining} before requesting another interpretation`);
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

      // Set cooldown
      const cooldownTime = Date.now() + (COOLDOWN_MINUTES * 60 * 1000);
      setCooldownUntil(cooldownTime);
      localStorage.setItem('tarotCooldown', cooldownTime.toString());
    } catch (err) {
      setError('Failed to generate interpretation');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const resetReading = () => {
    setDrawnCards([]);
    setCustomCardInput('');
    setSpreadImage('');
    setResult(null);
    setQuestion('');
    setError(null);
  };

  const handleModeChange = (newMode: 'random' | 'custom') => {
    setMode(newMode);
    resetReading();
  };

  const handleSpreadImageUpload = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setSpreadImage(reader.result as string);
      };
      reader.readAsDataURL(file);
    }
  };

  const parseCustomCards = (input: string): DrawnCard[] => {
    const lines = input.trim().split('\n').filter(line => line.trim());
    const parsed: DrawnCard[] = [];

    // Suit abbreviations mapping
    const suitAbbreviations: Record<string, string> = {
      'pent': 'pentacles',
      'pents': 'pentacles',
      'pentacle': 'pentacles',
      'coin': 'pentacles',
      'coins': 'pentacles',
      'wand': 'wands',
      'cup': 'cups',
      'sword': 'swords'
    };

    lines.forEach((line, index) => {
      const trimmed = line.trim();
      let cardName = trimmed;
      let reversed = false;

      // Check if line indicates reversed
      const reversedMatch = trimmed.match(/^(.+?)\s*[\(\-]\s*reversed\s*[\)]?$/i);
      if (reversedMatch) {
        cardName = reversedMatch[1].trim();
        reversed = true;
      }

      // Normalize abbreviations (e.g., "10 of pents" -> "ten of pentacles")
      let normalizedName = cardName;

      // Replace suit abbreviations
      Object.entries(suitAbbreviations).forEach(([abbr, full]) => {
        const regex = new RegExp(`\\b${abbr}\\b`, 'gi');
        normalizedName = normalizedName.replace(regex, full);
      });

      // Replace number shortcuts (e.g., "10" -> "Ten")
      const numberMap: Record<string, string> = {
        '1': 'Ace', '2': 'Two', '3': 'Three', '4': 'Four', '5': 'Five',
        '6': 'Six', '7': 'Seven', '8': 'Eight', '9': 'Nine', '10': 'Ten'
      };
      Object.entries(numberMap).forEach(([num, word]) => {
        const regex = new RegExp(`^${num}\\b`, 'i');
        normalizedName = normalizedName.replace(regex, word);
      });

      // Find matching card (try exact match first, then normalized)
      let card = cards.find(c =>
        c.name.toLowerCase() === cardName.toLowerCase()
      );

      if (!card) {
        card = cards.find(c =>
          c.name.toLowerCase() === normalizedName.toLowerCase()
        );
      }

      if (card) {
        parsed.push({
          cardId: card.id,
          position: index + 1,
          reversed
        });
      }
    });

    return parsed;
  };

  const submitCustomReading = () => {
    if (!customCardInput.trim()) {
      setError('Please enter your cards');
      return;
    }

    const drawn = parseCustomCards(customCardInput);

    if (drawn.length === 0) {
      setError('No matching cards found. Please check card names.');
      return;
    }

    setDrawnCards(drawn);
    setResult(null);
    setError(null);
  };

  const getCardById = (cardId: number): Card | undefined => {
    return cards.find((c) => c.id === cardId);
  };

  return (
    <div className="tarot-reading">
      <h1>Gypsy</h1>

      {error && <div className="error">{error}</div>}

      {cooldownUntil && cooldownUntil > Date.now() && (
        <div className="cooldown-notice">
          ⏳ Next interpretation available in: <strong>{timeRemaining}</strong>
        </div>
      )}

      <div className="mode-toggle">
        <button
          className={mode === 'random' ? 'active' : ''}
          onClick={() => handleModeChange('random')}
        >
          Random Draw
        </button>
        <button
          className={mode === 'custom' ? 'active' : ''}
          onClick={() => handleModeChange('custom')}
        >
          Custom Reading
        </button>
      </div>

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
                {spread.name} ({spread.position_count} cards)
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
          {mode === 'random' && (
            <button
              onClick={drawCards}
              disabled={!selectedDeck || !selectedSpread || loading}
            >
              Draw Cards
            </button>
          )}
          {drawnCards.length > 0 && !result && (
            <button
              onClick={getInterpretation}
              disabled={loading || (cooldownUntil !== null && cooldownUntil > Date.now())}
            >
              {loading ? 'Generating...' : cooldownUntil && cooldownUntil > Date.now() ? `Wait ${timeRemaining}` : 'Get Interpretation'}
            </button>
          )}
          {(drawnCards.length > 0 || result) && (
            <button onClick={resetReading} disabled={loading}>
              New Reading
            </button>
          )}
        </div>
      </div>

      {mode === 'custom' && (
        <div className="custom-input">
          <h2>Enter Your Cards</h2>
          <p className="instruction">Type each card on a new line. Add "(reversed)" after the card name if needed.</p>
          <textarea
            value={customCardInput}
            onChange={(e) => setCustomCardInput(e.target.value)}
            placeholder={'Example:\nThe Fool\nThe Magician (reversed)\nThe High Priestess'}
            rows={8}
            disabled={loading}
          />

          <div className="image-upload-section">
            <h3>Upload Spread Photo (Optional)</h3>
            <p className="instruction">Upload a photo of your entire card spread for reference</p>
            <input
              type="file"
              accept="image/*"
              onChange={handleSpreadImageUpload}
              disabled={loading}
            />
            {spreadImage && (
              <div className="spread-preview">
                <img src={spreadImage} alt="Card spread" />
              </div>
            )}
          </div>

          <button
            onClick={submitCustomReading}
            disabled={loading || !customCardInput.trim()}
            className="submit-custom"
          >
            Submit Reading
          </button>
        </div>
      )}

      {drawnCards.length > 0 && (
        <div className="drawn-cards">
          <h2>Your Cards</h2>
          <div className="cards-grid">
            {drawnCards.map((drawnCard) => {
              const card = getCardById(drawnCard.cardId);
              if (!card) return null;
              return (
                <div
                  key={drawnCard.cardId + '-' + drawnCard.position}
                  className={'card' + (drawnCard.reversed ? ' reversed' : '')}
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

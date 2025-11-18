import { useState, useEffect } from 'react';
import { api } from '../services/api';
import type {
  Deck,
  SpreadType,
  Card,
  DrawnCard,
  InterpretationResponse,
  TonePreference,
  AIContextPreview,
  QuestionRefinement,
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
  const [refinedQuestion, setRefinedQuestion] = useState<QuestionRefinement | null>(null);
  const [tone, setTone] = useState<TonePreference>('warm');
  const [drawnCards, setDrawnCards] = useState<DrawnCard[]>([]);
  const [customCardInput, setCustomCardInput] = useState('');
  const [spreadImage, setSpreadImage] = useState<string>('');
  const [_result, setResult] = useState<InterpretationResponse | null>(null);
  const [streamingText, setStreamingText] = useState('');
  const [isStreaming, setIsStreaming] = useState(false);
  const [readingId, setReadingId] = useState<number | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [cooldownUntil, setCooldownUntil] = useState<number | null>(null);
  const [timeRemaining, setTimeRemaining] = useState<string>('');

  // New features state
  const [showContext, setShowContext] = useState(false);
  const [aiContext, setAiContext] = useState<AIContextPreview | null>(null);
  const [showQuestionRefine, setShowQuestionRefine] = useState(false);
  const [refiningQuestion, setRefiningQuestion] = useState(false);
  const [followUpQuestion, setFollowUpQuestion] = useState('');
  const [followUpAnswer, setFollowUpAnswer] = useState<string | null>(null);
  const [loadingFollowUp, setLoadingFollowUp] = useState(false);
  const [selectedCardForExplanation, setSelectedCardForExplanation] = useState<number | null>(null);
  const [cardExplanation, setCardExplanation] = useState<string | null>(null);
  const [loadingCardExplanation, setLoadingCardExplanation] = useState(false);
  const [hoveredCard, setHoveredCard] = useState<number | null>(null);

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
    setStreamingText('');
    setReadingId(null);
    setFollowUpAnswer(null);
    setCardExplanation(null);
    setError(null);
  };

  // Fetch AI context preview
  const fetchAIContext = async () => {
    if (!selectedDeck || !selectedSpread || drawnCards.length === 0) return;

    try {
      const context = await api.getAIContext(selectedSpread, selectedDeck, drawnCards);
      setAiContext(context);
      setShowContext(true);
    } catch (err) {
      console.error('Failed to fetch AI context:', err);
    }
  };

  // Refine question with AI
  const handleRefineQuestion = async () => {
    if (!question.trim()) {
      setError('Please enter a question first');
      return;
    }

    setRefiningQuestion(true);
    try {
      const refinement = await api.refineQuestion(question);
      setRefinedQuestion(refinement);
      setShowQuestionRefine(true);
    } catch (err) {
      setError('Failed to refine question');
      console.error(err);
    } finally {
      setRefiningQuestion(false);
    }
  };

  const useRefinedQuestion = () => {
    if (refinedQuestion) {
      setQuestion(refinedQuestion.refined);
      setShowQuestionRefine(false);
    }
  };

  // Get streaming interpretation
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
    setIsStreaming(true);
    setStreamingText('');
    setError(null);
    setResult(null);
    setReadingId(null);

    try {
      await api.generateStreamingInterpretation(
        {
          spreadTypeId: selectedSpread,
          deckId: selectedDeck,
          question: question || undefined,
          cardsDrawn: drawnCards,
          tone,
        },
        (chunk) => {
          setStreamingText((prev) => prev + chunk);
        },
        (id) => {
          setReadingId(id);
          setIsStreaming(false);
          setLoading(false);

          // Set cooldown
          const cooldownTime = Date.now() + (COOLDOWN_MINUTES * 60 * 1000);
          setCooldownUntil(cooldownTime);
          localStorage.setItem('tarotCooldown', cooldownTime.toString());
        },
        (errorMsg) => {
          setError(errorMsg);
          setIsStreaming(false);
          setLoading(false);
        }
      );
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to generate interpretation');
      setIsStreaming(false);
      setLoading(false);
    }
  };

  // Ask follow-up question
  const askFollowUp = async () => {
    if (!readingId || !followUpQuestion.trim()) {
      setError('Please enter a follow-up question');
      return;
    }

    setLoadingFollowUp(true);
    setError(null);

    try {
      const response = await api.askFollowUp(readingId, followUpQuestion);
      setFollowUpAnswer(response.answer);
      setFollowUpQuestion('');
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to answer follow-up question');
    } finally {
      setLoadingFollowUp(false);
    }
  };

  // Explain specific card
  const explainCard = async (position: number) => {
    if (!readingId) return;

    setLoadingCardExplanation(true);
    setSelectedCardForExplanation(position);
    setCardExplanation(null);

    try {
      const response = await api.explainCard(readingId, position);
      setCardExplanation(response.explanation);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to explain card');
    } finally {
      setLoadingCardExplanation(false);
    }
  };

  const resetReading = () => {
    setDrawnCards([]);
    setCustomCardInput('');
    setSpreadImage('');
    setResult(null);
    setStreamingText('');
    setReadingId(null);
    setQuestion('');
    setRefinedQuestion(null);
    setShowQuestionRefine(false);
    setFollowUpAnswer(null);
    setFollowUpQuestion('');
    setCardExplanation(null);
    setSelectedCardForExplanation(null);
    setShowContext(false);
    setAiContext(null);
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

      // Normalize abbreviations
      let normalizedName = cardName;

      // Replace suit abbreviations
      Object.entries(suitAbbreviations).forEach(([abbr, full]) => {
        const regex = new RegExp(`\\b${abbr}\\b`, 'gi');
        normalizedName = normalizedName.replace(regex, full);
      });

      // Replace number shortcuts
      const numberMap: Record<string, string> = {
        '1': 'Ace', '2': 'Two', '3': 'Three', '4': 'Four', '5': 'Five',
        '6': 'Six', '7': 'Seven', '8': 'Eight', '9': 'Nine', '10': 'Ten'
      };
      Object.entries(numberMap).forEach(([num, word]) => {
        const regex = new RegExp(`^${num}\\b`, 'i');
        normalizedName = normalizedName.replace(regex, word);
      });

      // Find matching card
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
    setStreamingText('');
    setReadingId(null);
    setFollowUpAnswer(null);
    setCardExplanation(null);
    setError(null);
  };

  const getCardById = (cardId: number): Card | undefined => {
    return cards.find((c) => c.id === cardId);
  };

  const toneDescriptions: Record<TonePreference, string> = {
    warm: 'Warm & Empowering',
    direct: 'Direct & Practical',
    mystical: 'Mystical & Poetic',
    analytical: 'Analytical & Psychological',
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
          <label htmlFor="tone">Interpretation Style:</label>
          <select
            id="tone"
            value={tone}
            onChange={(e) => setTone(e.target.value as TonePreference)}
            disabled={loading}
          >
            {Object.entries(toneDescriptions).map(([value, label]) => (
              <option key={value} value={value}>
                {label}
              </option>
            ))}
          </select>
        </div>

        <div className="form-group question-group">
          <label htmlFor="question">Your Question (optional):</label>
          <div className="question-input-wrapper">
            <input
              id="question"
              type="text"
              value={question}
              onChange={(e) => setQuestion(e.target.value)}
              placeholder="What would you like guidance on?"
              disabled={loading}
            />
            {question.trim() && (
              <button
                onClick={handleRefineQuestion}
                disabled={refiningQuestion || loading}
                className="refine-btn"
                title="Get AI help to refine your question"
              >
                {refiningQuestion ? '...' : '✨'}
              </button>
            )}
          </div>
        </div>

        {showQuestionRefine && refinedQuestion && (
          <div className="question-refinement">
            <p><strong>AI suggests:</strong> {refinedQuestion.refined}</p>
            <div className="refinement-actions">
              <button onClick={useRefinedQuestion} className="use-refined">
                Use This
              </button>
              <button onClick={() => setShowQuestionRefine(false)} className="keep-original">
                Keep Original
              </button>
            </div>
          </div>
        )}

        <div className="actions">
          {mode === 'random' && (
            <button
              onClick={drawCards}
              disabled={!selectedDeck || !selectedSpread || loading}
            >
              Draw Cards
            </button>
          )}
          {drawnCards.length > 0 && !streamingText && !readingId && (
            <>
              <button
                onClick={fetchAIContext}
                disabled={loading}
                className="preview-btn"
                title="Preview what the AI will see"
              >
                Preview AI Context
              </button>
              <button
                onClick={getInterpretation}
                disabled={loading || (cooldownUntil !== null && cooldownUntil > Date.now())}
              >
                {loading ? 'Generating...' : cooldownUntil && cooldownUntil > Date.now() ? `Wait ${timeRemaining}` : 'Get Interpretation'}
              </button>
            </>
          )}
          {(drawnCards.length > 0 || streamingText || readingId) && (
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

      {/* AI Context Preview */}
      {showContext && aiContext && (
        <div className="ai-context-preview">
          <h2>AI Context Preview</h2>
          <div className="context-info">
            <p><strong>Spread:</strong> {aiContext.spread.name}</p>
            {aiContext.spread.description && (
              <p><strong>Description:</strong> {aiContext.spread.description}</p>
            )}
            {aiContext.pastReadingsCount > 0 && (
              <p className="past-readings-badge">
                💡 Learning from {aiContext.pastReadingsCount} highly-rated past reading{aiContext.pastReadingsCount > 1 ? 's' : ''}
              </p>
            )}
            <h3>Cards Being Analyzed:</h3>
            <ul className="context-cards">
              {aiContext.cards.map((card, idx) => (
                <li key={idx}>
                  <strong>Position {idx + 1} - {card.position}:</strong> {card.card}
                  {card.reversed && ' (Reversed)'}
                  <br />
                  <em>{card.positionMeaning}</em>
                  <br />
                  Keywords: {card.keywords.join(', ')}
                </li>
              ))}
            </ul>
          </div>
          <button onClick={() => setShowContext(false)}>Close Preview</button>
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
                  className={'card' + (drawnCard.reversed ? ' reversed' : '') + (hoveredCard === drawnCard.position ? ' highlighted' : '')}
                  onMouseEnter={() => setHoveredCard(drawnCard.position)}
                  onMouseLeave={() => setHoveredCard(null)}
                  onClick={() => readingId && explainCard(drawnCard.position)}
                  title={readingId ? 'Click for detailed explanation' : `${card.name}\nKeywords: ${(drawnCard.reversed ? card.reversed_keywords : card.upright_keywords).slice(0, 3).join(', ')}`}
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
                  {readingId && (
                    <button className="explain-card-btn">
                      {loadingCardExplanation && selectedCardForExplanation === drawnCard.position ? 'Loading...' : 'Explain This Card'}
                    </button>
                  )}
                </div>
              );
            })}
          </div>
        </div>
      )}

      {/* Card Explanation Modal */}
      {cardExplanation && selectedCardForExplanation && (
        <div className="card-explanation-modal">
          <div className="modal-content">
            <h2>Card Explanation - Position {selectedCardForExplanation}</h2>
            <div className="explanation-text">{cardExplanation}</div>
            <button onClick={() => { setCardExplanation(null); setSelectedCardForExplanation(null); }}>
              Close
            </button>
          </div>
        </div>
      )}

      {/* Streaming Interpretation */}
      {(isStreaming || streamingText) && (
        <div className="interpretation">
          <h2>Interpretation</h2>
          <div className="interpretation-text streaming">
            {streamingText}
            {isStreaming && <span className="cursor">▊</span>}
          </div>
        </div>
      )}

      {/* Follow-up Questions */}
      {readingId && streamingText && !isStreaming && (
        <div className="follow-up-section">
          <h3>Ask a Follow-up Question</h3>
          <div className="follow-up-input-wrapper">
            <input
              type="text"
              value={followUpQuestion}
              onChange={(e) => setFollowUpQuestion(e.target.value)}
              placeholder="Ask for clarification or more detail..."
              disabled={loadingFollowUp}
            />
            <button
              onClick={askFollowUp}
              disabled={!followUpQuestion.trim() || loadingFollowUp}
            >
              {loadingFollowUp ? 'Asking...' : 'Ask'}
            </button>
          </div>

          {followUpAnswer && (
            <div className="follow-up-answer">
              <h4>Answer:</h4>
              <p>{followUpAnswer}</p>
            </div>
          )}
        </div>
      )}
    </div>
  );
}

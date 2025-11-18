interface MobileAppTeaserProps {
  onClose: () => void;
}

export default function MobileAppTeaser({ onClose }: MobileAppTeaserProps) {
  return (
    <div className="mobile-app-modal">
      <div className="mobile-app-modal-content">
        <button className="modal-close" onClick={onClose} aria-label="Close">
          ✕
        </button>
        <h3>📱 Get the Gypsy Mobile App</h3>
        <p>
          Experience unlimited AI-powered tarot readings on the go! The mobile app offers enhanced features and a seamless reading experience.
        </p>
        <div className="app-features">
          <span className="feature-badge">✨ Unlimited Readings</span>
          <span className="feature-badge">📴 Offline Access</span>
          <span className="feature-badge">📜 Reading History</span>
          <span className="feature-badge">🎴 Advanced Spreads</span>
        </div>
        <p style={{ fontSize: '0.9rem', marginTop: '1rem', color: 'rgba(255, 255, 255, 0.7)' }}>
          Coming soon to iOS and Android
        </p>
      </div>
    </div>
  );
}

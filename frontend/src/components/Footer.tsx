import logo from '../assets/well-walt-logo.png';

export default function Footer() {
  return (
    <footer className="footer">
      <div className="footer-content">
        <a href="https://www.wellwaltstudios.com" target="_blank" rel="noopener noreferrer" className="footer-logo-link">
          <img src={logo} alt="Well Walt Studios Logo" className="footer-logo-image" />
        </a>
        <p className="footer-tagline">
          👩🏽‍💻 A creation by Well Walt Studios
        </p>
        <p className="footer-subtitle">
          Building apps that build people ✨
        </p>
      </div>
    </footer>
  );
}

# Gypsy Mobile 🔮📱

React Native mobile app for Gypsy - the AI-powered tarot reading platform.

## About

Gypsy Mobile brings the power of AI-enhanced tarot readings to your iOS and Android devices. Built with React Native and Expo, it connects to the same backend API as the web version to provide personalized tarot interpretations powered by Claude AI.

## Features

✨ **AI-Powered Readings**
- Streaming interpretations from Claude AI
- Multiple tone preferences (warm, direct, mystical, analytical)
- Context-aware card explanations

🎴 **Multiple Decks**
- Rider-Waite (Traditional)
- Marseille Tarot (Classic French)
- Thoth Tarot (Crowley's Occult)
- Wild Unknown (Nature & Animals)
- Modern Witch (Contemporary Urban)

📐 **Spread Types**
- Single Card
- 3-Card (Past, Present, Future)
- Celtic Cross
- And more

🎨 **Beautiful UI**
- Dark themed interface
- Smooth animations
- Intuitive navigation
- Responsive design

## Tech Stack

- **React Native** - Cross-platform mobile framework
- **Expo** - Development platform and toolchain
- **TypeScript** - Type-safe code
- **React Navigation** - Native navigation
- **Axios** - API client
- **Claude AI** - Natural language interpretations

## Prerequisites

- Node.js 18+
- npm or yarn
- Expo CLI (`npm install -g expo-cli`)
- iOS Simulator (Mac only) or Android Studio
- Expo Go app (for testing on physical devices)

## Setup

### 1. Install Dependencies

```bash
npm install
```

### 2. Configure API Endpoint

Edit `src/services/api.ts` and set your API URL:

```typescript
const API_BASE_URL = __DEV__
  ? 'http://YOUR_LOCAL_IP:3001/api'  // Replace with your computer's local IP
  : 'https://tarot-reader.vercel.app/api';
```

**Finding your local IP:**
- **Mac**: System Preferences → Network
- **Windows**: `ipconfig` in Command Prompt
- **Linux**: `ifconfig` or `ip addr`

**Example**: `http://192.168.1.100:3001/api`

### 3. Start the Backend

Make sure the Gypsy API backend is running:

```bash
# In the main gypsy repo
cd backend
npm run dev
```

The API should be running at `http://localhost:3001`

## Running the App

### Start Expo Development Server

```bash
npm start
```

This opens the Expo Developer Tools in your browser.

### Run on iOS Simulator (Mac only)

```bash
npm run ios
```

Or press `i` in the Expo Developer Tools.

### Run on Android Emulator

```bash
npm run android
```

Or press `a` in the Expo Developer Tools.

Make sure Android Studio is installed and an emulator is running.

### Run on Physical Device

1. Install **Expo Go** from App Store (iOS) or Play Store (Android)
2. Scan the QR code shown in the terminal or Expo Developer Tools
3. App will load on your device

**Note**: Your phone and computer must be on the same WiFi network.

## Project Structure

```
gypsy-mobile/
├── src/
│   ├── screens/
│   │   ├── HomeScreen.tsx          # Deck & spread selection
│   │   ├── ReadingScreen.tsx       # Card drawing
│   │   └── ResultsScreen.tsx       # AI interpretation
│   ├── services/
│   │   └── api.ts                  # API client
│   ├── types/
│   │   └── index.ts                # TypeScript types
│   ├── components/                 # Reusable components
│   └── constants/
│       └── theme.ts                # Colors, spacing, etc.
├── App.tsx                         # Main app & navigation
├── app.json                        # Expo configuration
└── package.json                    # Dependencies
```

## Screens

### 1. Home Screen
- Choose your tarot deck
- Select spread type
- Optionally enter a question
- Begin reading

### 2. Reading Screen
- View drawn cards
- See position meanings
- Check for reversed cards
- Request AI interpretation

### 3. Results Screen
- Read personalized interpretation
- Review cards in the reading
- Start a new reading

## Configuration

### API Base URL

Development (local testing):
```typescript
'http://192.168.1.100:3001/api'  // Your computer's local IP
```

Production (deployed app):
```typescript
'https://tarot-reader.vercel.app/api'
```

### Theme Customization

Edit `src/constants/theme.ts` to customize:
- Colors
- Spacing
- Font sizes
- Border radius
- Shadows

## Building for Production

### iOS (Requires Mac + Apple Developer Account)

```bash
# Build with EAS
eas build --platform ios

# Or create local build
expo build:ios
```

### Android

```bash
# Build with EAS
eas build --platform android

# Or create local build
expo build:android
```

## Related Projects

- **[gypsy](https://github.com/awalters4/gypsy)** - Web app + Backend API (monorepo)
- **[gypsy-mobile](https://github.com/well-walt-studios/gypsy-mobile)** - This mobile app

## API Documentation

See the main [Gypsy repository](https://github.com/awalters4/gypsy) for complete API documentation.

### Key Endpoints Used

- `GET /api/decks` - Get all tarot decks
- `GET /api/spreads` - Get all spread types
- `GET /api/cards` - Get cards (optionally filtered by deck)
- `POST /api/interpret` - Get AI interpretation
- `POST /api/readings` - Create a reading record

## Development Tips

### Debugging

- Shake your device to open the dev menu
- Enable Remote JS Debugging
- Use React Native Debugger

### Hot Reload

Code changes automatically reload in the app. If something breaks:
- Press `r` in terminal to reload
- Or shake device → Reload

### Common Issues

**"Unable to resolve module"**
- Clear cache: `expo start -c`
- Reinstall: `rm -rf node_modules && npm install`

**"Network request failed"**
- Check API URL in `api.ts`
- Ensure backend is running
- Verify phone and computer are on same network
- Use your local IP, not `localhost`

**iOS/Android build fails**
- Update Expo: `npm install expo@latest`
- Clear cache: `expo start -c`

## Contributing

This is a companion app to the main Gypsy project. See the main repo for contribution guidelines.

## License

MIT

## Support

For issues or questions:
- Open an issue on GitHub
- Check the main [Gypsy repository](https://github.com/awalters4/gypsy)

---

Made with 💜 by Well Walt Studios

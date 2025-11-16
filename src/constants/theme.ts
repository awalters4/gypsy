// Theme constants for Gypsy Mobile App

export const Colors = {
  // Dark theme (matching web app)
  background: '#1a0f2e',
  surface: '#2d1b4e',
  surfaceLight: '#3d2b5e',

  primary: '#9b59b6',
  primaryDark: '#8e44ad',
  primaryLight: '#bb8fce',

  accent: '#e67e22',
  accentLight: '#f39c12',

  text: '#ecf0f1',
  textSecondary: '#bdc3c7',
  textMuted: '#95a5a6',

  border: '#4a3b6e',
  borderLight: '#5a4b7e',

  success: '#27ae60',
  warning: '#f39c12',
  error: '#e74c3c',
  info: '#3498db',

  cardBackground: '#2d1b4e',
  cardHighlight: '#4a3b6e',

  // Special
  mystical: '#9b59b6',
  gold: '#f1c40f',
};

export const Spacing = {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32,
  xxl: 48,
};

export const BorderRadius = {
  sm: 4,
  md: 8,
  lg: 12,
  xl: 16,
  round: 999,
};

export const FontSize = {
  xs: 12,
  sm: 14,
  md: 16,
  lg: 18,
  xl: 24,
  xxl: 32,
  xxxl: 48,
};

export const FontWeight = {
  regular: '400' as const,
  medium: '500' as const,
  semibold: '600' as const,
  bold: '700' as const,
};

export const Shadows = {
  small: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
    elevation: 2,
  },
  medium: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 4.65,
    elevation: 4,
  },
  large: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 6 },
    shadowOpacity: 0.37,
    shadowRadius: 7.49,
    elevation: 8,
  },
};

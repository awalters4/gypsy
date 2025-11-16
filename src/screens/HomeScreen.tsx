import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  ScrollView,
  ActivityIndicator,
} from 'react-native';
import { Colors, Spacing, FontSize, BorderRadius, Shadows } from '../constants/theme';
import { Deck, SpreadType } from '../types';
import gypsyAPI from '../services/api';

export default function HomeScreen({ navigation }: any) {
  const [decks, setDecks] = useState<Deck[]>([]);
  const [spreads, setSpreads] = useState<SpreadType[]>([]);
  const [selectedDeck, setSelectedDeck] = useState<Deck | null>(null);
  const [selectedSpread, setSelectedSpread] = useState<SpreadType | null>(null);
  const [question, setQuestion] = useState('');
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    try {
      const [decksData, spreadsData] = await Promise.all([
        gypsyAPI.getDecks(),
        gypsyAPI.getSpreads(),
      ]);
      setDecks(decksData);
      setSpreads(spreadsData);
      if (decksData.length > 0) setSelectedDeck(decksData[0]);
      if (spreadsData.length > 0) setSelectedSpread(spreadsData[0]);
    } catch (error) {
      console.error('Failed to load data:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleStartReading = () => {
    if (!selectedDeck || !selectedSpread) return;

    navigation.navigate('Reading', {
      deckId: selectedDeck.id,
      spreadTypeId: selectedSpread.id,
      spread: selectedSpread,
      question: question.trim() || undefined,
    });
  };

  if (loading) {
    return (
      <View style={styles.centerContainer}>
        <ActivityIndicator size="large" color={Colors.primary} />
        <Text style={styles.loadingText}>Loading Gypsy...</Text>
      </View>
    );
  }

  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>🔮 Gypsy</Text>
        <Text style={styles.subtitle}>AI-Powered Tarot Readings</Text>
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Choose Your Deck</Text>
        {decks.map((deck) => (
          <TouchableOpacity
            key={deck.id}
            style={[
              styles.option,
              selectedDeck?.id === deck.id && styles.selectedOption,
            ]}
            onPress={() => setSelectedDeck(deck)}
          >
            <Text style={styles.optionTitle}>{deck.name}</Text>
            {deck.description && (
              <Text style={styles.optionDescription}>{deck.description}</Text>
            )}
          </TouchableOpacity>
        ))}
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Choose Your Spread</Text>
        {spreads.map((spread) => (
          <TouchableOpacity
            key={spread.id}
            style={[
              styles.option,
              selectedSpread?.id === spread.id && styles.selectedOption,
            ]}
            onPress={() => setSelectedSpread(spread)}
          >
            <Text style={styles.optionTitle}>
              {spread.name} ({spread.position_count} cards)
            </Text>
            {spread.description && (
              <Text style={styles.optionDescription}>{spread.description}</Text>
            )}
          </TouchableOpacity>
        ))}
      </View>

      <TouchableOpacity
        style={styles.startButton}
        onPress={handleStartReading}
        disabled={!selectedDeck || !selectedSpread}
      >
        <Text style={styles.startButtonText}>Begin Reading</Text>
      </TouchableOpacity>

      <View style={styles.footer}>
        <Text style={styles.footerText}>
          Powered by Claude AI • {decks.length} Decks Available
        </Text>
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  centerContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: Colors.background,
  },
  loadingText: {
    color: Colors.text,
    fontSize: FontSize.md,
    marginTop: Spacing.md,
  },
  header: {
    padding: Spacing.xl,
    alignItems: 'center',
    borderBottomWidth: 1,
    borderBottomColor: Colors.border,
  },
  title: {
    fontSize: FontSize.xxxl,
    color: Colors.primary,
    fontWeight: 'bold',
    marginBottom: Spacing.sm,
  },
  subtitle: {
    fontSize: FontSize.lg,
    color: Colors.textSecondary,
  },
  section: {
    padding: Spacing.lg,
  },
  sectionTitle: {
    fontSize: FontSize.lg,
    color: Colors.text,
    fontWeight: '600',
    marginBottom: Spacing.md,
  },
  option: {
    backgroundColor: Colors.surface,
    padding: Spacing.md,
    borderRadius: BorderRadius.lg,
    marginBottom: Spacing.sm,
    borderWidth: 2,
    borderColor: 'transparent',
  },
  selectedOption: {
    borderColor: Colors.primary,
    backgroundColor: Colors.surfaceLight,
  },
  optionTitle: {
    fontSize: FontSize.md,
    color: Colors.text,
    fontWeight: '600',
    marginBottom: Spacing.xs,
  },
  optionDescription: {
    fontSize: FontSize.sm,
    color: Colors.textSecondary,
  },
  startButton: {
    backgroundColor: Colors.primary,
    marginHorizontal: Spacing.lg,
    padding: Spacing.lg,
    borderRadius: BorderRadius.lg,
    alignItems: 'center',
    ...Shadows.medium,
    marginTop: Spacing.md,
  },
  startButtonText: {
    color: Colors.text,
    fontSize: FontSize.lg,
    fontWeight: 'bold',
  },
  footer: {
    padding: Spacing.xl,
    alignItems: 'center',
  },
  footerText: {
    color: Colors.textMuted,
    fontSize: FontSize.sm,
  },
});

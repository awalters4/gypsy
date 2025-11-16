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
import { CardInReading, Card, SpreadType } from '../types';
import gypsyAPI from '../services/api';

export default function ResultsScreen({ route, navigation }: any) {
  const { deckId, spreadTypeId, spread, question, cardsDrawn, cards } = route.params;
  const [loading, setLoading] = useState(true);
  const [interpretation, setInterpretation] = useState('');
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    getInterpretation();
  }, []);

  const getInterpretation = async () => {
    try {
      setLoading(true);
      setError(null);

      const result = await gypsyAPI.getInterpretation({
        spreadTypeId,
        deckId,
        cardsDrawn,
        question,
        tone: 'warm',
      });

      setInterpretation(result);
    } catch (err: any) {
      console.error('Failed to get interpretation:', err);
      setError(err.message || 'Failed to get interpretation. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const handleNewReading = () => {
    navigation.navigate('Home');
  };

  if (loading) {
    return (
      <View style={styles.centerContainer}>
        <ActivityIndicator size="large" color={Colors.primary} />
        <Text style={styles.loadingText}>
          The cards are speaking...
        </Text>
        <Text style={styles.loadingSubtext}>
          Claude AI is interpreting your reading
        </Text>
      </View>
    );
  }

  if (error) {
    return (
      <View style={styles.centerContainer}>
        <Text style={styles.errorText}>⚠️ {error}</Text>
        <TouchableOpacity
          style={styles.retryButton}
          onPress={getInterpretation}
        >
          <Text style={styles.retryButtonText}>Try Again</Text>
        </TouchableOpacity>
        <TouchableOpacity
          style={styles.homeButton}
          onPress={handleNewReading}
        >
          <Text style={styles.homeButtonText}>Back to Home</Text>
        </TouchableOpacity>
      </View>
    );
  }

  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>Your Interpretation</Text>
        <Text style={styles.spread}>{spread.name}</Text>
        {question && <Text style={styles.question}>{question}</Text>}
      </View>

      <View style={styles.interpretationContainer}>
        <Text style={styles.interpretation}>{interpretation}</Text>
      </View>

      <View style={styles.cardsSection}>
        <Text style={styles.cardsSectionTitle}>Cards in This Reading</Text>
        {cards.map((card: Card, index: number) => {
          const cardData = cardsDrawn[index];
          const position = spread.positions[index];
          return (
            <View key={index} style={styles.cardSummary}>
              <Text style={styles.cardPosition}>
                {position.name}:
              </Text>
              <Text style={styles.cardSummaryName}>
                {card.name}
                {cardData.reversed && ' (Reversed)'}
              </Text>
            </View>
          );
        })}
      </View>

      <TouchableOpacity
        style={styles.newReadingButton}
        onPress={handleNewReading}
      >
        <Text style={styles.newReadingButtonText}>
          ✨ New Reading
        </Text>
      </TouchableOpacity>

      <View style={styles.footer}>
        <Text style={styles.footerText}>
          Remember: Tarot is a tool for reflection, not fortune-telling.
          {'\n'}Trust your intuition and inner wisdom.
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
    padding: Spacing.xl,
  },
  loadingText: {
    color: Colors.text,
    fontSize: FontSize.lg,
    marginTop: Spacing.md,
    textAlign: 'center',
  },
  loadingSubtext: {
    color: Colors.textSecondary,
    fontSize: FontSize.sm,
    marginTop: Spacing.sm,
    textAlign: 'center',
  },
  errorText: {
    color: Colors.error,
    fontSize: FontSize.md,
    textAlign: 'center',
    marginBottom: Spacing.lg,
  },
  retryButton: {
    backgroundColor: Colors.primary,
    paddingHorizontal: Spacing.xl,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.lg,
    marginTop: Spacing.md,
  },
  retryButtonText: {
    color: Colors.text,
    fontSize: FontSize.md,
    fontWeight: '600',
  },
  homeButton: {
    marginTop: Spacing.md,
    padding: Spacing.md,
  },
  homeButtonText: {
    color: Colors.textSecondary,
    fontSize: FontSize.md,
  },
  header: {
    padding: Spacing.xl,
    alignItems: 'center',
    borderBottomWidth: 1,
    borderBottomColor: Colors.border,
  },
  title: {
    fontSize: FontSize.xxl,
    color: Colors.primary,
    fontWeight: 'bold',
    marginBottom: Spacing.sm,
  },
  spread: {
    fontSize: FontSize.lg,
    color: Colors.textSecondary,
  },
  question: {
    fontSize: FontSize.md,
    color: Colors.accent,
    fontStyle: 'italic',
    textAlign: 'center',
    marginTop: Spacing.sm,
  },
  interpretationContainer: {
    padding: Spacing.lg,
    backgroundColor: Colors.surface,
    margin: Spacing.lg,
    borderRadius: BorderRadius.lg,
    borderLeftWidth: 4,
    borderLeftColor: Colors.primary,
    ...Shadows.medium,
  },
  interpretation: {
    fontSize: FontSize.md,
    color: Colors.text,
    lineHeight: FontSize.md * 1.6,
  },
  cardsSection: {
    padding: Spacing.lg,
  },
  cardsSectionTitle: {
    fontSize: FontSize.lg,
    color: Colors.text,
    fontWeight: '600',
    marginBottom: Spacing.md,
  },
  cardSummary: {
    flexDirection: 'row',
    marginBottom: Spacing.sm,
  },
  cardPosition: {
    fontSize: FontSize.sm,
    color: Colors.primary,
    fontWeight: '600',
    marginRight: Spacing.xs,
  },
  cardSummaryName: {
    fontSize: FontSize.sm,
    color: Colors.textSecondary,
    flex: 1,
  },
  newReadingButton: {
    backgroundColor: Colors.primary,
    marginHorizontal: Spacing.lg,
    padding: Spacing.lg,
    borderRadius: BorderRadius.lg,
    alignItems: 'center',
    ...Shadows.medium,
    marginTop: Spacing.md,
  },
  newReadingButtonText: {
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
    textAlign: 'center',
    fontStyle: 'italic',
  },
});

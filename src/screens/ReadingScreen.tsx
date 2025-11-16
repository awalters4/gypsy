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
import { Card, CardInReading, SpreadType } from '../types';
import gypsyAPI from '../services/api';

export default function ReadingScreen({ route, navigation }: any) {
  const { deckId, spreadTypeId, spread, question } = route.params;
  const [loading, setLoading] = useState(true);
  const [drawnCards, setDrawnCards] = useState<Card[]>([]);
  const [cardsInReading, setCardsInReading] = useState<CardInReading[]>([]);

  useEffect(() => {
    drawCards();
  }, []);

  const drawCards = async () => {
    try {
      const cards = await gypsyAPI.drawRandomCards(deckId, spread.position_count);
      setDrawnCards(cards);

      // Create CardInReading array
      const cardsData: CardInReading[] = cards.map((card, index) => ({
        cardId: card.id,
        position: index + 1,
        reversed: Math.random() > 0.7, // 30% chance of reversed
      }));
      setCardsInReading(cardsData);
    } catch (error) {
      console.error('Failed to draw cards:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleGetInterpretation = () => {
    navigation.navigate('Results', {
      deckId,
      spreadTypeId,
      spread,
      question,
      cardsDrawn: cardsInReading,
      cards: drawnCards,
    });
  };

  if (loading) {
    return (
      <View style={styles.centerContainer}>
        <ActivityIndicator size="large" color={Colors.primary} />
        <Text style={styles.loadingText}>Drawing cards...</Text>
      </View>
    );
  }

  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>Your Reading</Text>
        <Text style={styles.spread}>{spread.name}</Text>
        {question && <Text style={styles.question}>{question}</Text>}
      </View>

      <View style={styles.cardsContainer}>
        {drawnCards.map((card, index) => {
          const position = spread.positions[index];
          const isReversed = cardsInReading[index]?.reversed;

          return (
            <View key={index} style={styles.cardItem}>
              <View style={styles.cardHeader}>
                <Text style={styles.positionName}>
                  {position.name}
                </Text>
                <Text style={styles.positionMeaning}>
                  {position.meaning}
                </Text>
              </View>
              <View style={[
                styles.card,
                isReversed && styles.cardReversed
              ]}>
                <Text style={styles.cardName}>
                  {card.name}
                  {isReversed && ' ⟲'}
                </Text>
                <Text style={styles.cardType}>
                  {card.card_type} • {card.suit || card.archetype}
                </Text>
              </View>
            </View>
          );
        })}
      </View>

      <TouchableOpacity
        style={styles.interpretButton}
        onPress={handleGetInterpretation}
      >
        <Text style={styles.interpretButtonText}>
          ✨ Get AI Interpretation
        </Text>
      </TouchableOpacity>

      <TouchableOpacity
        style={styles.redrawButton}
        onPress={drawCards}
      >
        <Text style={styles.redrawButtonText}>
          🔄 Draw Again
        </Text>
      </TouchableOpacity>
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
    fontSize: FontSize.xxl,
    color: Colors.primary,
    fontWeight: 'bold',
    marginBottom: Spacing.sm,
  },
  spread: {
    fontSize: FontSize.lg,
    color: Colors.textSecondary,
    marginBottom: Spacing.xs,
  },
  question: {
    fontSize: FontSize.md,
    color: Colors.accent,
    fontStyle: 'italic',
    textAlign: 'center',
    marginTop: Spacing.sm,
  },
  cardsContainer: {
    padding: Spacing.lg,
  },
  cardItem: {
    marginBottom: Spacing.lg,
  },
  cardHeader: {
    marginBottom: Spacing.sm,
  },
  positionName: {
    fontSize: FontSize.md,
    color: Colors.primary,
    fontWeight: '600',
  },
  positionMeaning: {
    fontSize: FontSize.sm,
    color: Colors.textSecondary,
    marginTop: Spacing.xs,
  },
  card: {
    backgroundColor: Colors.surface,
    padding: Spacing.lg,
    borderRadius: BorderRadius.lg,
    borderWidth: 2,
    borderColor: Colors.primary,
    ...Shadows.medium,
  },
  cardReversed: {
    borderColor: Colors.accent,
    backgroundColor: Colors.surfaceLight,
  },
  cardName: {
    fontSize: FontSize.lg,
    color: Colors.text,
    fontWeight: 'bold',
    marginBottom: Spacing.xs,
  },
  cardType: {
    fontSize: FontSize.sm,
    color: Colors.textSecondary,
  },
  interpretButton: {
    backgroundColor: Colors.primary,
    marginHorizontal: Spacing.lg,
    padding: Spacing.lg,
    borderRadius: BorderRadius.lg,
    alignItems: 'center',
    ...Shadows.medium,
    marginTop: Spacing.md,
  },
  interpretButtonText: {
    color: Colors.text,
    fontSize: FontSize.lg,
    fontWeight: 'bold',
  },
  redrawButton: {
    backgroundColor: 'transparent',
    marginHorizontal: Spacing.lg,
    padding: Spacing.md,
    borderRadius: BorderRadius.lg,
    alignItems: 'center',
    marginTop: Spacing.sm,
    marginBottom: Spacing.xl,
    borderWidth: 1,
    borderColor: Colors.border,
  },
  redrawButtonText: {
    color: Colors.textSecondary,
    fontSize: FontSize.md,
  },
});

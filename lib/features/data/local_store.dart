import 'package:final_exam_practice/features/domain/deck.dart';
import 'package:final_exam_practice/features/domain/card_item.dart';

class LocalStore {
  final List<Deck> _decks = [];
  final Map<String, List<CardItem>> _cardsByDeck = {};

  void seedIfEmpty() {
    if (_decks.isNotEmpty) return;

    final d1 = const Deck(id: 'd1', title: 'Information Security');
    final d2 = const Deck(id: 'd2', title: 'Flutter / SMD');

    _decks.addAll([d1, d2]);
    _cardsByDeck[d1.id] = [
      const CardItem(
        id: 'c1',
        deckId: 'd1',
        question: 'Define CIA triad.',
        answer: 'Confidentiality, Integrity, Availability.',
      ),
    ];
    _cardsByDeck[d2.id] = [];
  }

  // Decks
  List<Deck> getDecks() => List.unmodifiable(_decks);

  void addDeck(Deck deck) {
    _decks.add(deck);
    _cardsByDeck.putIfAbsent(deck.id, () => []);
  }

  void deleteDeck(String deckId) {
    _decks.removeWhere((d) => d.id == deckId);
    _cardsByDeck.remove(deckId);
  }

  // Cards
  List<CardItem> getCards(String deckId) =>
      List.unmodifiable(_cardsByDeck[deckId] ?? const []);

  void addCard(CardItem card) {
    _cardsByDeck.putIfAbsent(card.deckId, () => []);
    _cardsByDeck[card.deckId]!.add(card);
  }

  void deleteCard(String deckId, String cardId) {
    _cardsByDeck[deckId]?.removeWhere((c) => c.id == cardId);
  }
}

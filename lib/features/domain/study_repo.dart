import 'deck.dart';
import 'card_item.dart';

abstract class StudyRepo {
  // 1. Deck Functions
  Future<List<Deck>> getDecks();
  Future<void> addDeck(Deck deck);
  Future<void> deleteDeck(String deckId);

  // 2. Card Functions
  Future<List<CardItem>> getCards(String deckId);
  Future<void> addCard(CardItem card);
  Future<void> deleteCard(String deckId, String cardId);
}

import 'package:final_exam_practice/features/domain/study_repo.dart';
import 'package:final_exam_practice/features/domain/deck.dart';
import 'package:final_exam_practice/features/domain/card_item.dart';
import 'package:final_exam_practice/features/data/local_store.dart';

class StudyRepoImpl implements StudyRepo {
  final LocalStore store;
  StudyRepoImpl(this.store);

  @override
  Future<List<Deck>> getDecks() async => store.getDecks();

  @override
  Future<void> addDeck(Deck deck) async => store.addDeck(deck);

  @override
  Future<void> deleteDeck(String deckId) async => store.deleteDeck(deckId);

  @override
  Future<List<CardItem>> getCards(String deckId) async => store.getCards(deckId);

  @override
  Future<void> addCard(CardItem card) async => store.addCard(card);

  @override
  Future<void> deleteCard(String deckId, String cardId) async =>
      store.deleteCard(deckId, cardId);
}

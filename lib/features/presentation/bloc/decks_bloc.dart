import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_exam_practice/features/domain/deck.dart';
import 'package:final_exam_practice/features/domain/study_repo.dart';

abstract class DecksEvent {}
class LoadDecks extends DecksEvent {}
class AddDeck extends DecksEvent { final String title; AddDeck(this.title); }
class DeleteDeck extends DecksEvent { final String deckId; DeleteDeck(this.deckId); }

class DecksState {
  final List<Deck> decks;
  DecksState(this.decks);
}

class DecksBloc extends Bloc<DecksEvent, DecksState> {
  final StudyRepo repo;

  DecksBloc(this.repo) : super(DecksState(const [])) {
    on<LoadDecks>((e, emit) async {
      emit(DecksState(await repo.getDecks()));
    });

    on<AddDeck>((e, emit) async {
      final t = e.title.trim();
      final title = t.isEmpty ? 'Deck ${state.decks.length + 1}' : t;

      await repo.addDeck(Deck(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
      ));

      add(LoadDecks());
    });

    on<DeleteDeck>((e, emit) async {
      await repo.deleteDeck(e.deckId);
      add(LoadDecks());
    });
  }
}

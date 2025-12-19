import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_exam_practice/features/domain/card_item.dart';
import 'package:final_exam_practice/features/domain/study_repo.dart';

abstract class CardsEvent {}
class LoadCards extends CardsEvent {}
class AddCard extends CardsEvent { final String q, a; AddCard(this.q, this.a); }
class DeleteCard extends CardsEvent { final String cardId; DeleteCard(this.cardId); }

class CardsState {
  final List<CardItem> cards;
  CardsState(this.cards);
}

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  final StudyRepo repo;
  final String deckId;

  CardsBloc(this.repo, this.deckId) : super(CardsState(const [])) {
    on<LoadCards>((e, emit) async {
      emit(CardsState(await repo.getCards(deckId)));
    });

    on<AddCard>((e, emit) async {
      final q = e.q.trim(), a = e.a.trim();
      if (q.isEmpty || a.isEmpty) return;

      await repo.addCard(CardItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        deckId: deckId,
        question: q,
        answer: a,
      ));
      add(LoadCards());
    });

    on<DeleteCard>((e, emit) async {
      await repo.deleteCard(deckId, e.cardId);
      add(LoadCards());
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_exam_practice/features/domain/card_item.dart';
import 'package:final_exam_practice/features/domain/study_repo.dart';

abstract class QuizEvent {}
class LoadQuiz extends QuizEvent {}
class ToggleQA extends QuizEvent {}
class NextCard extends QuizEvent {}

class QuizState {
  final List<CardItem> cards;
  final int i;
  final bool showAnswer;
  QuizState(this.cards, this.i, this.showAnswer);
}

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final StudyRepo repo;
  final String deckId;

  QuizBloc(this.repo, this.deckId) : super(QuizState(const [], 0, false)) {
    on<LoadQuiz>((e, emit) async {
      emit(QuizState(await repo.getCards(deckId), 0, false));
    });

    on<ToggleQA>((e, emit) {
      emit(QuizState(state.cards, state.i, !state.showAnswer));
    });

    on<NextCard>((e, emit) {
      if (state.cards.isEmpty) return;
      emit(QuizState(state.cards, (state.i + 1) % state.cards.length, false));
    });
  }
}

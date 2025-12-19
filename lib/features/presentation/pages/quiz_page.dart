import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_exam_practice/features/presentation/bloc/quiz_bloc.dart';

class QuizPage extends StatelessWidget {
  final String title;
  const QuizPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz: $title')),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (_, state) {
          if (state.cards.isEmpty) return const Center(child: Text('No cards.'));

          final card = state.cards[state.i];
          final text = state.showAnswer ? card.answer : card.question;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Text(
                        text,
                        key: ValueKey(text),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => context.read<QuizBloc>().add(ToggleQA()),
                        child: Text(state.showAnswer ? 'Hide Answer' : 'Show Answer'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => context.read<QuizBloc>().add(NextCard()),
                        child: const Text('Next'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

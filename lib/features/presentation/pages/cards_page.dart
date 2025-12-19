import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:final_exam_practice/features/presentation/bloc/cards_bloc.dart';
import 'package:final_exam_practice/features/presentation/bloc/quiz_bloc.dart';
import 'package:final_exam_practice/features/presentation/pages/card_form_page.dart';
import 'package:final_exam_practice/features/presentation/pages/quiz_page.dart';

class CardsPage extends StatelessWidget {
  final String deckId;
  final String title;

  const CardsPage({super.key, required this.deckId, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () {
              final repo = context.read<CardsBloc>().repo;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => QuizBloc(repo, deckId)..add(LoadQuiz()),
                    child: QuizPage(title: title),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<CardsBloc>(), // keeps same bloc
                child: const CardFormPage(),
              ),
            ),
          );
        },
      ),
      body: BlocBuilder<CardsBloc, CardsState>(
        builder: (_, state) {
          if (state.cards.isEmpty) return const Center(child: Text('No cards.'));

          return ListView(
            children: state.cards.map((c) {
              return _CardTile(
                q: c.question,
                a: c.answer,
                onDelete: () => context.read<CardsBloc>().add(DeleteCard(c.id)),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class _CardTile extends StatefulWidget {
  final String q;
  final String a;
  final VoidCallback onDelete;

  const _CardTile({required this.q, required this.a, required this.onDelete});

  @override
  State<_CardTile> createState() => _CardTileState();
}

class _CardTileState extends State<_CardTile> {
  bool open = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => open = !open),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: const [BoxShadow(blurRadius: 4, offset: Offset(0, 2))],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(open ? "${widget.q}\n\n${widget.a}" : widget.q),
            ),
            IconButton(icon: const Icon(Icons.delete), onPressed: widget.onDelete),
          ],
        ),
      ),
    );
  }
}

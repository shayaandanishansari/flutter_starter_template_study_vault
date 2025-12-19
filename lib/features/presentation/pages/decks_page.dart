import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:final_exam_practice/features/presentation/bloc/decks_bloc.dart';
import 'package:final_exam_practice/features/presentation/bloc/cards_bloc.dart';
import 'package:final_exam_practice/features/presentation/pages/cards_page.dart';

class DecksPage extends StatelessWidget {
  const DecksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Decks')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final c = TextEditingController();
          final title = await showDialog<String>(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Add Deck'),
              content: TextField(controller: c, decoration: const InputDecoration(hintText: 'Deck name')),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                ElevatedButton(onPressed: () => Navigator.pop(context, c.text), child: const Text('Add')),
              ],
            ),
          );
          if (title == null) return;
          context.read<DecksBloc>().add(AddDeck(title));
        },
      ),
      body: BlocBuilder<DecksBloc, DecksState>(
        builder: (_, state) {
          if (state.decks.isEmpty) {
            return const Center(child: Text('No decks.'));
          }

          return ListView(
            children: state.decks.map((d) {
              return ListTile(
                title: Text(d.title),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => context.read<DecksBloc>().add(DeleteDeck(d.id)),
                ),
                onTap: () {
                  final repo = context.read<DecksBloc>().repo;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => CardsBloc(repo, d.id)..add(LoadCards()),
                        child: CardsPage(deckId: d.id, title: d.title),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

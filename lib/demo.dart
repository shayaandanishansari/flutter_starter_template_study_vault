import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:final_exam_practice/features/presentation/bloc/decks_bloc.dart';

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
              content: TextField(
                controller: c,
                decoration: const InputDecoration(hintText: 'Deck title'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, c.text.trim()),
                  child: const Text('Add'),
                ),
              ],
            ),
          );

          if (title == null || title.isEmpty) return;
          context.read<DecksBloc>().add(AddDeck(title));
        },
      ),
      body: BlocBuilder<DecksBloc, DecksState>(
        builder: (context, state) {
          if (state.decks.isEmpty) {
            return const Center(child: Text('No decks yet.'));
          }

          return ListView.builder(
            itemCount: state.decks.length,
            itemBuilder: (context, i) {
              final d = state.decks[i];
              return ListTile(
                title: Text(d.title),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => context.read<DecksBloc>().add(DeleteDeck(d.id)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

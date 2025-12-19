import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_exam_practice/features/presentation/bloc/cards_bloc.dart';

class CardFormPage extends StatefulWidget {
  const CardFormPage({super.key});

  @override
  State<CardFormPage> createState() => _CardFormPageState();
}

class _CardFormPageState extends State<CardFormPage> {
  final q = TextEditingController();
  final a = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Card')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(controller: q, decoration: const InputDecoration(hintText: 'Question')),
            const SizedBox(height: 8),
            TextField(controller: a, decoration: const InputDecoration(hintText: 'Answer')),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                context.read<CardsBloc>().add(AddCard(q.text, a.text));
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

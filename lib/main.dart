import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/data/local_store.dart';
import 'features/data/study_repo_impl.dart';
import 'features/domain/study_repo.dart';

import 'features/presentation/bloc/decks_bloc.dart';
import 'features/presentation/pages/decks_page.dart';

void main() {
  final store = LocalStore()..seedIfEmpty();
  final StudyRepo repo = StudyRepoImpl(store);

  runApp(MyApp(repo: repo));
}

class MyApp extends StatelessWidget {
  final StudyRepo repo;
  const MyApp({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StudyVault',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        scaffoldBackgroundColor: Colors.blueGrey
      ),
      home: BlocProvider(
        create: (_) => DecksBloc(repo)..add(LoadDecks()),
        child: const DecksPage(),
      ),
    );
  }
}

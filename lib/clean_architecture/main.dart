import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_schulung/clean_architecture/data/repositories/mock_advice_repository.dart';
import 'package:flutter_schulung/clean_architecture/domain/repositories/advice_repository.dart';
import 'package:flutter_schulung/clean_architecture/presentation/screens/home_screen.dart';

void main() {
  runApp(
    RepositoryProvider<AdviceRepository>(
      create: (context) => MockAdviceRepository(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

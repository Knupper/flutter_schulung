import 'package:flutter/material.dart';
import 'package:flutter_schulung/clean_architecture/presentation/pages/advice_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clean Architecture'),
      ),
      body: const AdvicePageProvider(),
    );
  }
}

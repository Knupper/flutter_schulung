import 'package:flutter/material.dart';
import 'package:flutter_schulung/clean_architecture/presentation/pages/advice_page.dart';
import 'package:flutter_schulung/clean_architecture/presentation/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clean Architecture'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SettingsScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: const AdvicePageProvider(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO open add Advice Screen
        },
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}

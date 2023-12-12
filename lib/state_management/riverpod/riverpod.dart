import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_schulung/state_management/riverpod/advice_river_provider.dart';
import 'package:http/http.dart' as http;

// State notifier provider holding the state
final randomAdviceProvider = StateNotifierProvider<AdviceRiverProvider, AdviceRiverState>(
  (ref) => AdviceRiverProvider(client: http.Client()),
);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, _) {
                final state = ref.watch(randomAdviceProvider);

                if (state.isLoading) {
                  return const CircularProgressIndicator();
                }

                if (state.error.isNotEmpty) {
                  return Text(state.error);
                }

                return Text(state.advice);
              },
            ),
            Container(
              color: Colors.blueAccent,
              child: Consumer(
                builder: (context, ref, _) {
                  final state = ref.watch(randomAdviceProvider);

                  if (state.isLoading) {
                    return const CircularProgressIndicator();
                  }

                  if (state.error.isNotEmpty) {
                    return Text(state.error);
                  }

                  if(state.advice.isEmpty) {
                    return const Text('No advice');
                  }
                  return Text(state.advice.toUpperCase());
                },
              ),
            ),
            Consumer(
              builder: (context, ref, _) {
                return OutlinedButton(
                  onPressed: () => ref.read(randomAdviceProvider.notifier).fetch(),
                  child: const Text('Press me!'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

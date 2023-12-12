import 'package:flutter/material.dart';
import 'package:flutter_schulung/state_management/provider/advice_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<AdviceProvider>(
        create: (context) => AdviceProvider(client: http.Client()),
        child: const HomePage(),
      ),
    );
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
            Consumer<AdviceProvider>(
              builder: (BuildContext context, AdviceProvider value, Widget? child) {
                if (value.isLoading) {
                  return const CircularProgressIndicator();
                }

                if (value.error.isNotEmpty) {
                  return Text(value.error);
                }

                return Text(value.advice);
              },
            ),
            OutlinedButton(
              onPressed: () => Provider.of<AdviceProvider>(context, listen: false).fetch(),
              child: const Text('Press me!'),
            )
          ],
        ),
      ),
    );
  }
}

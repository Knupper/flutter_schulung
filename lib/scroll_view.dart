import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Scrollview Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: ListView.builder(
        itemCount: 10000,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ColorfulContainer(color: Colors.orange, size: (index + 1.0)),
          );
        },
      ),
    );
  }
}

class ColorfulContainer extends StatelessWidget {
  const ColorfulContainer({
    super.key,
    required this.color,
    this.size = 200,
  });

  const ColorfulContainer.red({super.key, this.size = 200}) : color = Colors.red;

  const ColorfulContainer.yellow({super.key, this.size = 200}) : color = Colors.yellow;

  const ColorfulContainer.green({super.key, this.size = 200}) : color = Colors.green;

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    debugPrint('ColorfulContainer.build: $color, $size');
    return Container(
      color: color,
      height: size,
      width: size,
    );
  }
}

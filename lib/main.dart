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
      title: 'Flutter Demo',
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
      body: Flex(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        direction: Axis.vertical,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 4,
                child: ColorfulContainer.red(),
              ),
              Expanded(
                flex: 2,
                child: ColorfulContainer.yellow(),
              ),
              Expanded(
                flex: 4,
                child: ColorfulContainer.green(),
              ),
            ],
          ),
          const ColorfulContainer.red(),
          const ColorfulContainer.yellow(),
          const ColorfulContainer.green(),
          Flexible(
            child: Text(
              'Hello World Flutter Demo Home Page Flutter Demo Home Page Flutter Demo Home Page Flutter Demo Home Page Hello World Flutter Demo Home Page Flutter Demo Home Page Flutter Demo Home Page Flutter Demo Home Page Hello World Flutter Demo Home Page Flutter Demo Home Page Flutter Demo Home Page Flutter Demo Home Page',
              style: Theme.of(context).textTheme.displayMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class ColorfulContainer extends StatelessWidget {
  const ColorfulContainer({
    super.key,
    required this.color,
  });

  const ColorfulContainer.red({super.key}) : color = Colors.red;

  const ColorfulContainer.yellow({super.key}) : color = Colors.yellow;

  const ColorfulContainer.green({super.key}) : color = Colors.green;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: 200,
      width: 200,
    );
  }
}

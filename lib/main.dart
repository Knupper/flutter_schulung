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
      themeMode: ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
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

// Task 2
// ColorfulContainer gets a new size value
// Column should be filled with ColorfulContainers

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
        mainAxisAlignment: MainAxisAlignment.start,
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
          ElevatedButton(
            onPressed: () => debugPrint('outline pressed'),
            child: const Text('Elevated Button'),
          ),
          OutlinedButton(
            onPressed: () => debugPrint('outline pressed'),
            child: const Text('Outline Button'),
          ),
          TextButton(
            onPressed: () => debugPrint('outline pressed'),
            child: const Text('Text Button'),
          ),
          ElevatedButton.icon(
            onPressed: () => debugPrint('outline pressed'),
            icon: const Icon(Icons.add),
            label: const Text('label'),
          ),
          OutlinedButton.icon(
            onPressed: () => debugPrint('outline pressed'),
            icon: const Icon(Icons.add),
            label: const Text('label'),
          ),
          TextButton.icon(
            onPressed: () => debugPrint('outline pressed'),
            icon: const Icon(Icons.add),
            label: const Text('label'),
          ),
          IconButton(
            onPressed: () => debugPrint('iconButton'),
            icon: const Icon(Icons.sledding),
          ),
          Flexible(
            child: InkWell(
              onTap: () => debugPrint('Text clicked'),
              child: Text(
                'Hello World Flutter Demo Home Page Flutter Demo Home Page Flutter Demo Home Page Flutter Demo Home Page Hello World Flutter Demo Home Page Flutter Demo Home Page Flutter Demo Home Page Flutter Demo Home Page Hello World Flutter Demo Home Page Flutter Demo Home Page Flutter Demo Home Page Flutter Demo Home Page',
                style: Theme.of(context).textTheme.displayMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
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
    this.size = 200,
  });

  const ColorfulContainer.red({super.key, this.size = 200}) : color = Colors.red;

  const ColorfulContainer.yellow({super.key, this.size = 200}) : color = Colors.yellow;

  const ColorfulContainer.green({super.key, this.size = 200}) : color = Colors.green;

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      height: size,
      width: size,
    );
  }
}

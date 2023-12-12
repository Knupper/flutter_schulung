import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

class ColorfulContainer extends StatefulWidget {
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
  State<ColorfulContainer> createState() => _ColorfulContainerState();
}

class _ColorfulContainerState extends State<ColorfulContainer> {
  late double _size;

  @override
  void initState() {
    super.initState();
    _size = widget.size;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final tmpSize = _size == widget.size ? widget.size * 2 : widget.size;
        setState(() {
          _size = tmpSize;
          // ...
        });
        debugPrint('ColorfulContainer tapped _size : $_size');
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        height: _size,
        width: _size,
        child: const CustomCheckbox(),
      ),
    );
  }
}

// TASK 3
// Create a own class for a CheckBox widget
// The widget should have a label and a checkbox
// https://api.flutter.dev/flutter/material/Checkbox-class.html

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({super.key, this.initialValue = false});

  final bool initialValue;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _value;

  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _value,
          onChanged: (_) => _onChanged(),
        ),
        const Text('Label'),
      ],
    );
  }

  void _onChanged() {
    setState(() {
      _value = !_value;
    });
  }
}

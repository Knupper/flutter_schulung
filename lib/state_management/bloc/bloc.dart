import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_schulung/state_management/bloc/advice_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<AdviceBloc>(
        create: (context) =>
        AdviceBloc(client: http.Client())
          ..add(const FetchRandomAdvice()),
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
              BlocBuilder<AdviceBloc, AdviceState>(
                builder: (BuildContext context, AdviceState state) {
                  switch (state) {
                    case AdviceStateInitial _:
                      return const CircularProgressIndicator();
                    case AdviceStateLoading _:
                      return const CircularProgressIndicator();
                    case AdviceStateError error:
                      return Text(error.message);
                    case AdviceStateLoaded loaded:
                      return Text(loaded.advice);
                  }
                },
              ),
              OutlinedButton(
                onPressed: () => context.read<AdviceBloc>().add(const FetchRandomAdvice()),
                child: const Text('Press me!'),
              )
            ],
          ),
        )
    );
  }
}

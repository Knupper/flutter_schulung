import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_schulung/state_management/cubit/advice_cubit.dart';
import 'package:flutter_schulung/state_management/cubit/funny_cubit.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AdviceCubit>(
            create: (context) => AdviceCubit(client: http.Client())..fetch(),
          ),
          BlocProvider<FunnyCubit>(create: (context) => FunnyCubit()),
        ],
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
            BlocConsumer<AdviceCubit, AdviceState>(
              listener: (context, state) {
                if (state is AdviceStateLoaded) {
                  context.read<FunnyCubit>().adviceChanged(advice: state.advice);
                }
              },
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
              onPressed: () => context.read<AdviceCubit>().fetch(),
              child: const Text('Press me!'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => context.read<FunnyCubit>().reverse(),
              child: const Text('Reverse me!'),
            ),
            OutlinedButton(
              onPressed: () => context.read<FunnyCubit>().capslock(),
              child: const Text('CAPSLOCK me!'),
            ),
            BlocBuilder<FunnyCubit, FunnyState>(
              builder: (context, state) {
                if (state is FunnyStateLoaded) {
                  return Text('Funny Advice: ${state.advice}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}

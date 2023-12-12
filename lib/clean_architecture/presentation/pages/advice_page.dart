import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_schulung/clean_architecture/app/error_card.dart';
import 'package:flutter_schulung/clean_architecture/app/loading_spinner.dart';
import 'package:flutter_schulung/clean_architecture/domain/repositories/advice_repository.dart';
import 'package:flutter_schulung/clean_architecture/domain/use_cases/advice_use_case.dart';
import 'package:flutter_schulung/clean_architecture/presentation/components/advice/advice_card.dart';
import 'package:flutter_schulung/clean_architecture/presentation/components/advice/cubit/advice_cubit.dart';

class AdvicePageProvider extends StatelessWidget {
  const AdvicePageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdviceCubit>(
      create: (context) => AdviceCubit(
        useCase: AdviceUseCase(
          repository: RepositoryProvider.of<AdviceRepository>(context),
        ),
      )..fetchRandom(),
      child: const AdvicePage(),
    );
  }
}

class AdvicePage extends StatelessWidget {
  const AdvicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 400,
            height: 400,
            child: BlocBuilder<AdviceCubit, AdviceState>(
              builder: (context, state) {
                switch (state) {
                  case AdviceStateInitial _:
                  case AdviceStateLoading _:
                    return const LoadingSpinner();
                  case AdviceStateError _:
                    return const ErrorCard();
                  case AdviceStateLoaded loaded:
                    return AdviceCard(
                      advice: loaded.advice,
                    );
                }
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          OutlinedButton(
            onPressed: () => context.read<AdviceCubit>().fetchRandom(),
            child: const Text('Random Advice'),
          ),
          const SizedBox(
            height: 16,
          ),
          OutlinedButton(
            onPressed: () => context.read<AdviceCubit>().fetch(id: '33'),
            child: const Text('Specific Advice 33'),
          ),
        ],
      ),
    );
  }
}

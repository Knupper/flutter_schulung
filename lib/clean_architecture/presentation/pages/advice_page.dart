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
      )..fetch(),
      child: const AdvicePage(),
    );
  }
}

class AdvicePage extends StatelessWidget {
  const AdvicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdviceCubit, AdviceState>(
      builder: (context, state) {
        switch (state) {
          case AdviceStateInitial _:
          case AdviceStateLoading _:
            return const LoadingSpinner();
          case AdviceStateError _:
            return const ErrorCard();
          case AdviceStateLoaded loaded:
            return Center(
              child: Column(
                children: [
                  AdviceCard(
                    advice: loaded.advice,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  OutlinedButton(
                    onPressed: () => context.read<AdviceCubit>().fetch(),
                    child: const Text('example'),
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}

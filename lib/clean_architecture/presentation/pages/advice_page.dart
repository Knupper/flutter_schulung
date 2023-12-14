import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                  case AdviceStateError error:
                    return ErrorCard(message: error.message);
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
            key: const Key('random_advice'),
            onPressed: () => context.read<AdviceCubit>().fetchRandom(),
            child: Text('button_random_advice'.tr()),
          ),
          const SizedBox(
            height: 16,
          ),
          const _AdviceForm(),
        ],
      ),
    );
  }
}

class _AdviceForm extends StatefulWidget {
  const _AdviceForm({
    super.key,
  });

  @override
  State<_AdviceForm> createState() => _AdviceFormState();
}

class _AdviceFormState extends State<_AdviceForm> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _idController,
              decoration: const InputDecoration(
                label: Text('Advice Id'),
                hintText: 'Enter an advice id (only numbers are allowed)',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an advice id';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  // ;
                });
                debugPrint('value: $value');
              },
            ),
          ),
          OutlinedButton(
            key: const Key('specific_advice'),
            onPressed: () {
              final isValid = _formKey.currentState?.validate();
              if (isValid == true) {
                final id = _idController.text;
                context.read<AdviceCubit>().fetch(id: id);
                _idController.text = '';
              }
            },
            child: Text('button_specific_advice'.tr(namedArgs: {'id': _idController.text})),
          ),
        ],
      ),
    );
  }
}

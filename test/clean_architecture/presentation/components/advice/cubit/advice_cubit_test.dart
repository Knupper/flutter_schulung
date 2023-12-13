import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_schulung/clean_architecture/domain/entities/advice_entity.dart';
import 'package:flutter_schulung/clean_architecture/domain/use_cases/advice_use_case.dart';
import 'package:flutter_schulung/clean_architecture/presentation/components/advice/cubit/advice_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAdviceUseCase extends Mock implements AdviceUseCase {}

void main() {
  group('AdviceCubit', () {
    late AdviceUseCase useCase;

    blocTest(
      'should emit AdviceStateLoaded after calling fetchRandom()',
      setUp: () {
        useCase = MockAdviceUseCase();
        when(() => useCase.getRandomAdvice()).thenAnswer(
          (_) async => Right(
            AdviceEntity(advice: 'test', id: 42),
          ),
        );

        // create mocks for MockAdviceUseCase
      },
      build: () => AdviceCubit(useCase: useCase),
      act: (cubit) => cubit.fetchRandom(),
      expect: () => const [
        AdviceStateLoading(),
        AdviceStateLoaded(advice: 'test', id: 42),
      ],
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_schulung/clean_architecture/app/error_card.dart';
import 'package:flutter_schulung/clean_architecture/app/loading_spinner.dart';
import 'package:flutter_schulung/clean_architecture/presentation/components/advice/cubit/advice_cubit.dart';
import 'package:flutter_schulung/clean_architecture/presentation/pages/advice_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAdviceCubit extends MockCubit<AdviceState> implements AdviceCubit {}

void main() {
  Widget widgetUnderTest({required AdviceCubit cubit}) {
    return MaterialApp(
      home: BlocProvider<AdviceCubit>(
        create: (context) => cubit,
        child: const Scaffold(
          body: AdvicePage(),
        ),
      ),
    );
  }

  group('AdvicePage', () {
    final mockCubit = MockAdviceCubit();

    group('should display correct element based on state', () {
      //  blocTest<AdviceCubit, AdviceState>(
      //    'should display loading spinner',
      //    build: () => mockCubit,
      //    act: (cubit) => cubit.emit(const AdviceStateLoading()),
      //    expect: () => [
      //      const AdviceStateLoading(),
      //    ],
      //    verify: (_) {
      //      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      //    },
      //  );

      testWidgets('if state is [AdviceStateLoading] a LoadingSpinner is displayed', (widgetTester) async {
        whenListen(
          mockCubit,
          initialState: const AdviceStateLoading(),
          Stream.fromIterable([
            const AdviceStateLoading(),
          ]),
        );
        await widgetTester.pumpWidget(widgetUnderTest(cubit: mockCubit));
        await widgetTester.pump();

        expect(find.byType(LoadingSpinner), findsOneWidget);
      });

      testWidgets('if state is [AdviceStateInitial] a LoadingSpinner is displayed', (widgetTester) async {
        whenListen(
          mockCubit,
          initialState: const AdviceStateInitial(),
          Stream.fromIterable([
            const AdviceStateInitial(),
          ]),
        );
        await widgetTester.pumpWidget(widgetUnderTest(cubit: mockCubit));
        await widgetTester.pump();

        expect(find.byType(LoadingSpinner), findsOneWidget);
      });

      testWidgets('if state is [AdviceStateError] a ErrorCard is displayed', (widgetTester) async {
        whenListen(
          mockCubit,
          initialState: const AdviceStateInitial(),
          Stream.fromIterable([
            const AdviceStateError(message: 'message'),
          ]),
        );

        await widgetTester.pumpWidget(widgetUnderTest(cubit: mockCubit));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ErrorCard), findsOneWidget);
        expect(find.textContaining('message'), findsOneWidget);
      });
    });

    group('should handle button taps correctly', () {
      testWidgets(
        'after user clicks on random button',
        (widgetTester) async {
          when(() => mockCubit.fetchRandom()).thenAnswer((_) async => Future.value());

          whenListen(
            mockCubit,
            initialState: const AdviceStateInitial(),
            Stream.fromIterable([
              const AdviceStateLoading(),
            ]),
          );

          await widgetTester.pumpWidget(widgetUnderTest(cubit: mockCubit));

          await widgetTester.pump(); // for animated widgets
          // await widgetTester.pumpAndSettle(); // for all other widgets

          final button = find.byKey(const Key('random_advice'));

          await widgetTester.tap(button);

          verify(() => mockCubit.fetchRandom()).called(1);
        },
      );
    });
  });
}

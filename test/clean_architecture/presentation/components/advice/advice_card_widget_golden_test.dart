import 'package:flutter/material.dart';
import 'package:flutter_schulung/clean_architecture/presentation/components/advice/advice_card.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widgetUnderTest({String advice = 'test'}) {
    return MaterialApp(
      home: AdviceCard(
        advice: advice,
      ),
    );
  }

  group('AdviceCard', () {
    testWidgets('check layout for large texts', (widgetTester) async {
      // to adjust display size : widgetTester.binding.setSurfaceSize(Size(400, 400));
      // addTearDown(() => binding.setSurfaceSize(null));

      await widgetTester.pumpWidget(
        widgetUnderTest(
          advice: List.generate(1000, (index) => index.toString()).join(''),
        ),
      );
      await widgetTester.pumpAndSettle();
    });

    testWidgets('should display a short advice', (widgetTester) async {
      await widgetTester.pumpWidget(widgetUnderTest(advice: ''));
      await widgetTester.pumpAndSettle();

      await expectLater(find.byType(AdviceCard), matchesGoldenFile('golden_images/advice_card_short_golden.png'));
    });

    testWidgets('should display a long advice', (widgetTester) async {
      await widgetTester.pumpWidget(
        widgetUnderTest(
          advice: List.generate(1000, (index) => index.toString()).join(''),
        ),
      );
      await widgetTester.pumpAndSettle();

      await expectLater(find.byType(AdviceCard), matchesGoldenFile('golden_images/advice_card_long_golden.png'));
    });
  });
}

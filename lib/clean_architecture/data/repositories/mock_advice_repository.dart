import 'dart:math';

import 'package:flutter_schulung/clean_architecture/domain/entities/advice_entity.dart';
import 'package:flutter_schulung/clean_architecture/domain/repositories/advice_repository.dart';

class MockAdviceRepository implements AdviceRepository {
  final advices = List.generate(
    100,
    (index) => AdviceEntity(id: index, advice: 'Advice $index'),
  );

  @override
  Future<AdviceEntity> getAdvice() async {
    await Future.delayed(const Duration(seconds: 2));

    final random = Random().nextInt(advices.length);

    return advices[random];
  }
}

import 'dart:math';

import 'package:flutter_schulung/clean_architecture/domain/entities/advice_entity.dart';
import 'package:flutter_schulung/clean_architecture/domain/repositories/advice_repository.dart';

class MockAdviceRepository implements AdviceRepository {
  final advices = List.generate(
    100,
    (index) => AdviceEntity(id: index, advice: 'Advice $index'),
  );

  @override
  Future<AdviceEntity> getAdvice({int? id}) async {
    await Future.delayed(const Duration(seconds: 2));

    int selectedId;

    if (id == null) {
      selectedId = Random().nextInt(advices.length);
    } else {
      selectedId = id;
    }

    return advices[selectedId];
  }
}

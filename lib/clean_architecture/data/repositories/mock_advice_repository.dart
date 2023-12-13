import 'dart:math';

import 'package:either_dart/either.dart';
import 'package:flutter_schulung/clean_architecture/app/failure.dart';
import 'package:flutter_schulung/clean_architecture/domain/entities/advice_entity.dart';
import 'package:flutter_schulung/clean_architecture/domain/repositories/advice_repository.dart';

class MockAdviceRepository implements AdviceRepository {
  final advices = List.generate(
    100,
    (index) => AdviceEntity(id: index, advice: 'Advice $index'),
  );

  @override
  Future<Either<Failure, AdviceEntity>> getAdvice({int? id}) async {
    await Future.delayed(const Duration(seconds: 2));

    int selectedId;

    if (id == null) {
      selectedId = Random().nextInt(advices.length);
    } else {
      selectedId = id;
    }

    if (selectedId > advices.length) {
      return Left(OutOfRangeFailure());
    }

    return Right(advices[selectedId]);
  }
}

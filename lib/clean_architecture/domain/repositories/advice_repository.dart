import 'package:either_dart/either.dart';
import 'package:flutter_schulung/clean_architecture/app/failure.dart';
import 'package:flutter_schulung/clean_architecture/domain/entities/advice_entity.dart';

abstract class AdviceRepository {
  Future<Either<Failure, AdviceEntity>> getAdvice({int? id});
}

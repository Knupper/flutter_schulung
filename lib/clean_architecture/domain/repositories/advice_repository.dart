import 'package:flutter_schulung/clean_architecture/domain/entities/advice_entity.dart';

abstract class AdviceRepository {
  Future<AdviceEntity> getAdvice({int? id});
}

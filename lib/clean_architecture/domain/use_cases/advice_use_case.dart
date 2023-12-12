import 'package:flutter_schulung/clean_architecture/domain/entities/advice_entity.dart';
import 'package:flutter_schulung/clean_architecture/domain/repositories/advice_repository.dart';

class AdviceUseCase {
  AdviceUseCase({required this.repository});

  final AdviceRepository repository;

  Future<AdviceEntity> getRandomAdvice() async {
    final result = await repository.getAdvice();
    
    return result;
  }
}

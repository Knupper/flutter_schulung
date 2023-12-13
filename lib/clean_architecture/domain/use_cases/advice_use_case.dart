import 'package:either_dart/either.dart';
import 'package:flutter_schulung/clean_architecture/app/failure.dart';
import 'package:flutter_schulung/clean_architecture/domain/entities/advice_entity.dart';
import 'package:flutter_schulung/clean_architecture/domain/repositories/advice_repository.dart';

class AdviceUseCase {
  AdviceUseCase({required this.repository});

  final AdviceRepository repository;

  Future<Either<Failure, AdviceEntity>> getRandomAdvice() async {
    final result = await repository.getAdvice();

    return result;
  }

  Future<Either<Failure, AdviceEntity>> getSpecificAdvice({required String id}) async {
    final parsedInt = int.tryParse(id);
    if (parsedInt == null) {
      throw Exception('Only numbers are allowed');
    }

    // only ids that can be divided by three are allowed
    if (parsedInt % 3 != 0) {
      throw Exception('Only ids that can be divided by three are allowed');
    }

    final result = await repository.getAdvice(id: parsedInt);

    return result;
  }
}

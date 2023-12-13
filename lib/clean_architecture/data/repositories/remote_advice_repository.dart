import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter_schulung/clean_architecture/app/failure.dart';
import 'package:flutter_schulung/clean_architecture/data/data_sources/advice_remote_data_source.dart';
import 'package:flutter_schulung/clean_architecture/domain/entities/advice_entity.dart';
import 'package:flutter_schulung/clean_architecture/domain/repositories/advice_repository.dart';

class RemoteAdviceRepository implements AdviceRepository {
  RemoteAdviceRepository({required this.dataSource});

  final AdviceDataSource dataSource;

  @override
  Future<Either<Failure, AdviceEntity>> getAdvice({int? id}) async {
    try {
      final dto = await dataSource.getAdvice(id: id?.toString() ?? '');

      final entity = AdviceEntity(
        id: dto.id,
        advice: dto.advice,
      );

      return Right(entity);
    } on SocketException catch (_) {
      return Left(ServerFailure());
    } on Exception {
      return Left(UnknownFailure());
    }
  }
}

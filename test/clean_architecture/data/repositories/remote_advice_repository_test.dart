import 'package:flutter_schulung/clean_architecture/data/data_sources/advice_data_source_rest_api.dart';
import 'package:flutter_schulung/clean_architecture/data/dtos/advice_dto.dart';
import 'package:flutter_schulung/clean_architecture/data/repositories/remote_advice_repository.dart';
import 'package:flutter_schulung/clean_architecture/domain/entities/advice_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAdviceDataSource extends Mock implements AdviceDataSourceRestApi {}

void main() {
  group('RemoteAdviceRepository', () {
    final mockDataSource = MockAdviceDataSource();

    group('should return AdviceEntity', () {
      test('if dataSource returns AdviceDto', () async {
        final repositoryUnderTest = RemoteAdviceRepository(dataSource: mockDataSource);

        when(() => mockDataSource.getAdvice(id: any(named: 'id'))).thenAnswer(
          (_) async => Future.value(
            const AdviceDto(
              id: 1,
              advice: 'test',
            ),
          ),
        );

        final result = await repositoryUnderTest.getAdvice();

        expect(result.isRight, true);
        expect(result.right, isA<AdviceEntity>());
      });
    });

    group('should return Failure', () {});
  });
}

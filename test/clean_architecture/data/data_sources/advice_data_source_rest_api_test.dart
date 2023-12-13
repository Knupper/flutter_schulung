import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_schulung/clean_architecture/data/data_sources/advice_data_source_rest_api.dart';
import 'package:flutter_schulung/clean_architecture/data/dtos/advice_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

void main() {
  group('AdviceDataSourceRestApi', () {
    final mockClient = MockClient();

    setUpAll(() {
      debugPrint('setUpAll');
      registerFallbackValue(Uri());
    });

    setUp(() {
      debugPrint('setUp');
    });

    group('should return an AdviceDto', () {
      test('if no id parameter was set', () async {
        when(() => mockClient.get(Uri.parse('https://api.flutter-community.com/api/v1/advice/'),
            headers: any(named: 'headers'))).thenAnswer(
          (_) async => Future.value(
            Response(
              '{"advice": "test", "advice_id": 1}',
              200,
            ),
          ),
        );

        final dataSourceUnderTest = AdviceDataSourceRestApi(client: mockClient);

        final result = await dataSourceUnderTest.getAdvice();

        expect(result, isA<AdviceDto>());
      });

      test('if id parameter was set', () async {
        final dataSourceUnderTest = AdviceDataSourceRestApi(client: mockClient);

        when(() => mockClient.get(Uri.parse('https://api.flutter-community.com/api/v1/advice/42'),
            headers: any(named: 'headers'))).thenAnswer(
          (_) async => Future.value(
            Response(
              '{"advice": "test", "advice_id": 42}',
              200,
            ),
          ),
        );
        final result = await dataSourceUnderTest.getAdvice(id: '42');

        expect(result, isA<AdviceDto>());
        expect(result.id, 42);
      });
    });

    group('should throw an Exception', () {
      test('if statusCode was not 200', () async {
        final dataSourceUnderTest = AdviceDataSourceRestApi(client: mockClient);

        when(() => mockClient.get(Uri.parse('https://api.flutter-community.com/api/v1/advice/'),
            headers: any(named: 'headers'))).thenAnswer(
          (_) async => Future.value(
            Response(
              '{"advice": "test", "advice_id": 1}',
              402,
            ),
          ),
        );

        expect(() => dataSourceUnderTest.getAdvice(), throwsA(isA<Exception>()));
      });

      test('if client throws exception', () {
        final dataSourceUnderTest = AdviceDataSourceRestApi(client: mockClient);

        when(() => mockClient.get(Uri.parse('https://api.flutter-community.com/api/v1/advice/'),
            headers: any(named: 'headers'))).thenThrow(
          const SocketException('test'),
        );

        expect(() => dataSourceUnderTest.getAdvice(), throwsA(isA<Exception>()));
        verify(() => mockClient.get(Uri.parse('https://api.flutter-community.com/api/v1/advice/'),
            headers: any(named: 'headers'))).called(1);
      });
    });

    tearDown(() {
      reset(mockClient);
      debugPrint('tearDown');
    });

    tearDownAll(() {
      debugPrint('tearDownAll');
    });
  });
}

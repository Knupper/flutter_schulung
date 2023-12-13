import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_schulung/clean_architecture/data/data_sources/advice_remote_data_source.dart';
import 'package:flutter_schulung/clean_architecture/data/dtos/advice_dto.dart';
import 'package:http/http.dart' as http;

class AdviceDataSourceRestApi implements AdviceDataSource {
  const AdviceDataSourceRestApi({required this.client});

  final http.Client client;

  @override
  Future<AdviceDto> getAdvice({String id = ''}) async {
    try {
      final result = await client.get(
        Uri.parse('https://api.flutter-community.com/api/v1/advice/$id'),
        headers: {
          'accept': 'application/json',
        },
      );

      if (result.statusCode != 200) {
        throw Exception('Error while fetching advice');
      }

      return AdviceDto.fromJson(jsonDecode(result.body));
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Error while fetching advice');
    }
  }
}

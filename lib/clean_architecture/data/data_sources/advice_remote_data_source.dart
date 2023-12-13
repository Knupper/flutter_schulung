import 'package:flutter_schulung/clean_architecture/data/dtos/advice_dto.dart';

abstract class AdviceDataSource {
  Future<AdviceDto> getAdvice({String id = ''});
}

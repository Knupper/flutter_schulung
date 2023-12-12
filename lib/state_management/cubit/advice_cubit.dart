import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'advice_state.dart';

class AdviceCubit extends Cubit<AdviceState> {
  AdviceCubit({required this.client}) : super(const AdviceStateInitial());

  final http.Client client;

  Future<void> fetch() async {
    emit(const AdviceStateLoading());

    final response = await client.get(
      Uri.parse('https://api.flutter-community.com/api/v1/advice'),
      headers: {
        'accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      emit(const AdviceStateError(message: 'Ups, API Error. please try again!'));
      return;
    }

    emit(AdviceStateLoaded(advice: response.body));
  }
}

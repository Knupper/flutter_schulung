import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class AdviceRiverProvider extends StateNotifier<AdviceRiverState> {
  AdviceRiverProvider({required this.client}) : super(AdviceRiverState.initial());
  final http.Client client;

  Future<void> fetch() async {
    state = AdviceRiverState(
      advice: '',
      error: '',
      isLoading: true,
    );

    final response = await client.get(
      Uri.parse('https://api.flutter-community.com/api/v1/advice'),
      headers: {
        'accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      state = AdviceRiverState(
        advice: '',
        error: 'Ups, API Error. please try again!',
        isLoading: false,
      );

      return;
    }
    state = AdviceRiverState(
      advice: response.body,
      error: '',
      isLoading: false,
    );
    return;
  }
}

class AdviceRiverState {
  AdviceRiverState({
    required this.advice,
    required this.error,
    required this.isLoading,
  });

  final String advice;
  final String error;
  final bool isLoading;

  bool get hasError => error.isNotEmpty;

  factory AdviceRiverState.initial() => AdviceRiverState(
        advice: '',
        error: '',
        isLoading: false,
      );
}

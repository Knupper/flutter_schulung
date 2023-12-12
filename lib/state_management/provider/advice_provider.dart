import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdviceProvider extends ChangeNotifier {
  AdviceProvider({required this.client});

  final http.Client client;

  String _advice = '';
  bool _isLoading = false;
  String _error = '';

  String get error => _error;

  String get advice => _advice;

  bool get isLoading => _isLoading;

  Future<void> fetch() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    final response = await client.get(
      Uri.parse('https://api.flutter-community.com/api/v1/advice'),
      headers: {
        'accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      _error = 'Ups, API Error. please try again!';
      _isLoading = false;
      notifyListeners();
      return;
    }

    _advice = response.body;
    _isLoading = false;
    notifyListeners();

    return;
  }
}

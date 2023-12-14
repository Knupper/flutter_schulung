import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_schulung/clean_architecture/data/data_sources/advice_data_source_rest_api.dart';
import 'package:flutter_schulung/clean_architecture/data/repositories/remote_advice_repository.dart';
import 'package:flutter_schulung/clean_architecture/domain/repositories/advice_repository.dart';
import 'package:flutter_schulung/clean_architecture/presentation/screens/home_screen.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final client = http.Client();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('de', 'DE'),
      ],
      useOnlyLangCode: true,
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: RepositoryProvider<AdviceRepository>(
        create: (context) => RemoteAdviceRepository(
          dataSource: AdviceDataSourceRestApi(client: client),
        ),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const HomeScreen(),
    );
  }
}

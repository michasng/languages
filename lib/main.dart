import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:languages/models/app_model.dart';
import 'package:languages/models/language.dart';
import 'package:languages/routes/dictionary/dictionary_page.dart';
import 'package:text_to_speech/text_to_speech.dart';

void main() {
  _initDependencies();
  runApp(const _App());
}

void _initDependencies() {
  final getIt = GetIt.I;
  getIt.registerSingleton(
    AppModel(
      languages: (origin: Language.german, target: Language.russian),
      dictionaries: {},
    ),
  );
  getIt.registerSingleton(TextToSpeech());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Languages',
      debugShowCheckedModeBanner: false,
      home: const DictionaryPage(),
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

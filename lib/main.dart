import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:languages/models/app_model.dart';
import 'package:languages/models/language.dart';
import 'package:languages/routes/dictionary/dictionary_page.dart';
import 'package:languages/services/local_storage_repository.dart';
import 'package:localstorage/localstorage.dart';
import 'package:text_to_speech/text_to_speech.dart';

void main() async {
  await _initDependencies();
  runApp(const _App());
}

Future<void> _initDependencies() async {
  final getIt = GetIt.I;

  getIt.registerSingletonAsync(() async {
    await initLocalStorage();
    return localStorage;
  });
  getIt.registerSingletonWithDependencies(
    () => LocalStorageRepository(
      localStorage: getIt<LocalStorage>(),
      storageKey: 'app',
      defaultFactory: () => AppModel(
        languages: (origin: Language.german, target: Language.russian),
        dictionaries: {},
      ),
      fromJson: AppModel.fromJson,
    ),
    dependsOn: [LocalStorage],
  );
  getIt.registerSingleton(TextToSpeech());

  await getIt.allReady();
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

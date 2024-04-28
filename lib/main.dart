import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:languages/models/app_model.dart';
import 'package:languages/routes/term_grid/term_grid_page.dart';
import 'package:languages/services/local_storage_repository.dart';
import 'package:localstorage/localstorage.dart';
import 'package:text_to_speech/text_to_speech.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initDependencies();
  runApp(const _App());
}

Future<void> _initDependencies() async {
  final getIt = GetIt.I;

  getIt.registerSingletonAsync(() async {
    await initLocalStorage();
    return localStorage;
  });
  final rawDefaultAppModel =
      await rootBundle.loadString('default_app_model.json');
  getIt.registerSingletonWithDependencies(
    () => LocalStorageRepository(
      localStorage: getIt<LocalStorage>(),
      storageKey: 'app',
      defaultFactory: () {
        final json = jsonDecode(rawDefaultAppModel);
        return AppModel.fromJson(json as Map<String, dynamic>);
      },
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
      home: const TermGridPage(),
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:languages/routes/dictionary/dictionary_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

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

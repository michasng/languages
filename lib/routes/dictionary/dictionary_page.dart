import 'package:flutter/material.dart';
import 'package:languages/components/navigation_app_bar.dart';
import 'package:languages/routes/dictionary/components/dictionary.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationAppBar(),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Dictionary(),
      ),
    );
  }
}

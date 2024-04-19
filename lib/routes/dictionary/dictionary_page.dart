import 'package:flutter/material.dart';
import 'package:languages/routes/dictionary/components/dictionary.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Dictionary(),
      ),
    );
  }
}

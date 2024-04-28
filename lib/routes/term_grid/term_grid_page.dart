import 'package:flutter/material.dart';
import 'package:languages/components/navigation_app_bar.dart';
import 'package:languages/routes/term_grid/components/term_grid.dart';

class TermGridPage extends StatelessWidget {
  const TermGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationAppBar(),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: TermGrid(),
      ),
    );
  }
}

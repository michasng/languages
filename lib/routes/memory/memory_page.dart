import 'package:flutter/material.dart';
import 'package:languages/components/navigation_app_bar.dart';
import 'package:languages/routes/memory/components/memory_game.dart';

class MemoryPage extends StatelessWidget {
  const MemoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationAppBar(),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: MemoryGame(),
      ),
    );
  }
}

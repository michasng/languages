import 'package:flutter/material.dart';
import 'package:languages/components/navigation_app_bar.dart';
import 'package:languages/routes/emoji_grid/components/emoji_grid.dart';

class EmojiGridPage extends StatelessWidget {
  const EmojiGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationAppBar(),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: EmojiGrid(),
      ),
    );
  }
}

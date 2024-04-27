import 'package:flutter/material.dart';
import 'package:languages/routes/dictionary/dictionary_page.dart';
import 'package:languages/routes/emoji_grid/emoji_grid_page.dart';
import 'package:micha_core/micha_core.dart';

class NavigationAppBar extends AppBar {
  NavigationAppBar({super.key})
      : super(
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.book),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(
                        builder: (context) => const DictionaryPage(),
                      ),
                    );
                  },
                );
              },
            ),
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.image),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(
                        builder: (context) => const EmojiGridPage(),
                      ),
                    );
                  },
                );
              },
            ),
            const Gap(),
          ],
        );
}

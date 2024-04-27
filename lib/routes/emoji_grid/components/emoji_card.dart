import 'package:flutter/material.dart';
import 'package:languages/components/border_text.dart';
import 'package:languages/models/game/emoji.dart';

class EmojiCard extends StatelessWidget {
  final Emoji emoji;
  final VoidCallback? onTap;

  const EmojiCard({
    super.key,
    required this.emoji,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(emoji.assetPath),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BorderText(
                  emoji.name.targetPhrase,
                  style: Theme.of(context).textTheme.displaySmall,
                  blurRadius: 10,
                ),
                BorderText(
                  emoji.name.originPhrase,
                  style: Theme.of(context).textTheme.bodyLarge,
                  blurRadius: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

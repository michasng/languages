import 'package:flutter/material.dart';
import 'package:languages/models/game/emoji.dart';

class MemoryTextCard extends StatelessWidget {
  final Emoji emoji;
  final VoidCallback? onTap;

  const MemoryTextCard({
    super.key,
    required this.emoji,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Text(
          emoji.name.targetPhrase,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}

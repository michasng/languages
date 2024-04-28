import 'package:flutter/material.dart';
import 'package:languages/models/game/emoji.dart';

class MemoryImageCard extends StatelessWidget {
  final Emoji emoji;
  final VoidCallback? onTap;

  const MemoryImageCard({
    super.key,
    required this.emoji,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Image.asset(emoji.assetPath),
      ),
    );
  }
}

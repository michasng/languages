import 'package:flutter/material.dart';
import 'package:languages/components/border_text.dart';
import 'package:languages/models/term.dart';

class TermWidget extends StatelessWidget {
  final Term term;

  const TermWidget({
    super.key,
    required this.term,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (term.assetPath != null) Image.asset(term.assetPath!),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BorderText(
              term.target,
              style: Theme.of(context).textTheme.displaySmall,
              blurRadius: 10,
            ),
            BorderText(
              term.origin,
              style: Theme.of(context).textTheme.bodyLarge,
              blurRadius: 10,
            ),
          ],
        ),
      ],
    );
  }
}

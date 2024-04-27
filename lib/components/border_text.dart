import 'package:flutter/material.dart';

class BorderText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final Color borderColor;
  final double blurRadius;

  const BorderText(
    this.data, {
    super.key,
    this.style,
    this.borderColor = Colors.white,
    this.blurRadius = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    const offsets = [
      Offset(-1.5, -1.5), // bottom left
      Offset(1.5, -1.5), // bottom right
      Offset(1.5, 1.5), // top right
      Offset(-1.5, 1.5), // top left
    ];

    return Text(
      data,
      style: (style ?? const TextStyle()).copyWith(
        shadows: [
          for (final offset in offsets)
            Shadow(
              offset: offset,
              color: borderColor,
              blurRadius: blurRadius,
            ),
        ],
      ),
    );
  }
}

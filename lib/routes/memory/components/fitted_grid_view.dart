import 'dart:math';

import 'package:flutter/material.dart';

class FittedGridView extends StatelessWidget {
  final List<Widget> children;

  const FittedGridView({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final area = constraints.maxWidth * constraints.maxHeight;
        final maxChildArea = area / children.length;
        final maxChildSide = sqrt(maxChildArea);
        final rowCount = (constraints.maxHeight / maxChildSide).ceil();
        final childHeight = constraints.maxHeight / rowCount;
        final columnCount = (constraints.maxWidth / childHeight).ceil();

        return GridView.count(
          padding: const EdgeInsets.all(0),
          crossAxisCount: columnCount,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          childAspectRatio: 1,
          children: children,
        );
      },
    );
  }
}

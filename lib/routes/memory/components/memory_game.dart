import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:languages/components/term_widget.dart';
import 'package:languages/models/app_model.dart';
import 'package:languages/models/term.dart';
import 'package:languages/routes/memory/components/memory_model.dart';
import 'package:languages/services/local_storage_repository.dart';
import 'package:text_to_speech/text_to_speech.dart';

class MemoryGame extends StatefulWidget {
  final int uniqueCardCount;

  const MemoryGame({
    super.key,
    this.uniqueCardCount = 8,
  });

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  late MemoryModel<Term> _model;

  @override
  void initState() {
    super.initState();

    final appModelRepository = GetIt.I<LocalStorageRepository<AppModel>>();
    final appModel = appModelRepository.getOrDefault();
    final shuffledTerms = appModel.terms.toList()..shuffle();
    _model = MemoryModel(shuffledTerms.take(widget.uniqueCardCount).toSet());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textToSpeech = GetIt.I<TextToSpeech>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardCount = widget.uniqueCardCount * _model.cardCopyCount;

        final area = constraints.maxWidth * constraints.maxHeight;
        final maxCardArea = area / cardCount;
        final maxCardSide = sqrt(maxCardArea);
        final rowCount = (constraints.maxHeight / maxCardSide).ceil();
        final cardHeight = constraints.maxHeight / rowCount;
        final columnCount = (constraints.maxWidth / cardHeight).ceil();

        return GridView.count(
          padding: const EdgeInsets.all(0),
          crossAxisCount: columnCount,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          childAspectRatio: 1,
          children: [
            for (final card in _model.cards)
              Card(
                color: card.isMatched ? theme.colorScheme.primary : null,
                child: InkWell(
                  onTapUp: (_) {
                    setState(() {
                      _model.onTapCard(card);
                    });
                    textToSpeech.speak(card.value.target);
                  },
                  child: card.isFaceUp
                      ? FittedBox(
                          child: TermWidget(
                            term: card.value,
                          ),
                        )
                      : null,
                ),
              ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:languages/components/term_widget.dart';
import 'package:languages/models/app_model.dart';
import 'package:languages/models/term.dart';
import 'package:languages/routes/memory/components/fitted_grid_view.dart';
import 'package:languages/routes/memory/components/memory_model.dart';
import 'package:languages/services/local_storage_repository.dart';
import 'package:text_to_speech/text_to_speech.dart';

class MemoryGame extends StatefulWidget {
  final int uniqueCardCount;

  const MemoryGame({
    super.key,
    this.uniqueCardCount = 18,
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

    return FittedGridView(
      children: [
        for (final card in _model.cards)
          Card(
            key: ValueKey(card),
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
  }
}

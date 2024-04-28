import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:languages/components/term_widget.dart';
import 'package:languages/models/app_model.dart';
import 'package:languages/models/term.dart';
import 'package:languages/routes/memory/components/memory_model.dart';
import 'package:languages/services/local_storage_repository.dart';
import 'package:text_to_speech/text_to_speech.dart';

class MemoryGame extends StatefulWidget {
  const MemoryGame({super.key});

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
    _model = MemoryModel(shuffledTerms.take(8).toSet());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const minCardWidth = 200;
    final width = MediaQuery.of(context).size.width;
    final textToSpeech = GetIt.I<TextToSpeech>();

    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: (width / minCardWidth).floor(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
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
                  ? TermWidget(
                      term: card.value,
                    )
                  : null,
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:languages/models/app_model.dart';
import 'package:languages/models/game/emoji.dart';
import 'package:languages/routes/memory/components/memory_model.dart';
import 'package:languages/services/local_storage_repository.dart';

class MemoryGame extends StatefulWidget {
  const MemoryGame({super.key});

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  late MemoryModel<Emoji> _model;

  @override
  void initState() {
    super.initState();

    final appModelRepository = GetIt.I<LocalStorageRepository<AppModel>>();
    final appModel = appModelRepository.getOrDefault();
    _model = MemoryModel(appModel.emojis.take(8).toSet());
  }

  @override
  Widget build(BuildContext context) {
    const minCardWidth = 200;
    final width = MediaQuery.of(context).size.width;

    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: (width / minCardWidth).floor(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: [
        for (final card in _model.cards)
          Card(
            child: InkWell(
              onTapUp: (_) {
                setState(() {
                  _model.onTapCard(card);
                });
              },
              child: card.isFaceUp ? Image.asset(card.value.assetPath) : null,
            ),
          ),
      ],
    );
  }
}

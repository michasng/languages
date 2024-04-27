import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:languages/models/app_model.dart';
import 'package:languages/routes/emoji_grid/components/emoji_card.dart';
import 'package:languages/services/local_storage_repository.dart';
import 'package:text_to_speech/text_to_speech.dart';

class EmojiGrid extends StatelessWidget {
  const EmojiGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final appModelRepository = GetIt.I<LocalStorageRepository<AppModel>>();
    final appModel = appModelRepository.getOrDefault();
    final textToSpeech = GetIt.I<TextToSpeech>();

    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      crossAxisCount: 4,
      children: [
        for (final emoji in appModel.emojis)
          EmojiCard(
            emoji: emoji,
            onTap: () {
              textToSpeech.setLanguage(appModel.languages.target.code);
              textToSpeech.speak(emoji.name.targetPhrase);
            },
          ),
      ],
    );
  }
}

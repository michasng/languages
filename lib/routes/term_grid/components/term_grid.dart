import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:languages/components/term_widget.dart';
import 'package:languages/models/app_model.dart';
import 'package:languages/services/local_storage_repository.dart';
import 'package:text_to_speech/text_to_speech.dart';

class TermGrid extends StatelessWidget {
  const TermGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final appModelRepository = GetIt.I<LocalStorageRepository<AppModel>>();
    final appModel = appModelRepository.getOrDefault();
    final textToSpeech = GetIt.I<TextToSpeech>();

    const minCardWidth = 200;
    final width = MediaQuery.of(context).size.width;

    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: (width / minCardWidth).floor(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: [
        for (final term in appModel.terms)
          Card(
            child: InkWell(
              onTap: () {
                textToSpeech.setLanguage(appModel.languages.target.code);
                textToSpeech.speak(term.target);
              },
              child: TermWidget(term: term),
            ),
          ),
      ],
    );
  }
}

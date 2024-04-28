import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:languages/models/app_model.dart';
import 'package:languages/routes/dictionary/components/translation_field.dart';
import 'package:languages/services/local_storage_repository.dart';
import 'package:micha_core/micha_core.dart';
import 'package:text_to_speech/text_to_speech.dart';

class Dictionary extends StatefulWidget {
  const Dictionary({super.key});

  @override
  State<Dictionary> createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  final _appModelRepository = GetIt.I<LocalStorageRepository<AppModel>>();
  final _textToSpeech = GetIt.I<TextToSpeech>();

  @override
  Widget build(BuildContext context) {
    final appModel = _appModelRepository.getOrDefault();
    final terms = appModel.terms.toList();

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: terms.length,
            itemBuilder: (context, index) {
              final term = terms[index];

              return ListTile(
                key: ValueKey(term),
                title: Text(term.target),
                subtitle: Text(term.origin),
                leading: IconButton(
                  onPressed: () => _textToSpeech.speak(term.target),
                  icon: const Icon(Icons.volume_up),
                ),
                trailing: IconButton(
                  onPressed: () => setState(
                    () => _appModelRepository.update(
                      (appModel) => appModel.copyWith(
                        terms: appModel.terms
                            .where((item) => item != term)
                            .toSet(),
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          ),
        ),
        TranslationField(
          languages: appModel.languages,
          addTerm: (term) => setState(
            () => _appModelRepository.update(
              (appModel) => appModel.copyWith(
                terms: {
                  ...appModel.terms,
                  term,
                },
              ),
            ),
          ),
        ),
      ].separated(const Gap()),
    );
  }
}

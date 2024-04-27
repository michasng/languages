import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:languages/models/app_model.dart';
import 'package:languages/models/dictionary.dart' as dictionary_model;
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

  dictionary_model.Dictionary get _dictionary =>
      _appModelRepository.getOrDefault().activeDictionary;

  set _dictionary(dictionary_model.Dictionary dictionary) =>
      _appModelRepository.update(
        (appModel) => appModel.copyWith(
          dictionaries: {
            ...appModel.inactiveDictionaries,
            dictionary,
          },
        ),
      );

  Future<void> _speak(String phrase) async {
    final appModel = _appModelRepository.getOrDefault();
    _textToSpeech.setLanguage(appModel.languages.target.code);
    _textToSpeech.speak(phrase);
  }

  @override
  Widget build(BuildContext context) {
    final translations = _dictionary.translations.toList();
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: translations.length,
            itemBuilder: (context, index) {
              final translation = translations[index];

              return ListTile(
                key: ValueKey(translation),
                title: Text(translation.targetPhrase),
                subtitle: Text(translation.originPhrase),
                leading: IconButton(
                  onPressed: () => _speak(translation.targetPhrase),
                  icon: const Icon(Icons.volume_up),
                ),
                trailing: IconButton(
                  onPressed: () => setState(
                    () => _dictionary = _dictionary.copyWith(
                      translations: _dictionary.translations
                          .where((item) => item != translation)
                          .toSet(),
                    ),
                  ),
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          ),
        ),
        TranslationField(
          originLanguage: _dictionary.languages.origin,
          targetLanguage: _dictionary.languages.target,
          addTranslation: (translation) => setState(
            () => _dictionary = _dictionary.copyWith(
              translations: {
                ..._dictionary.translations,
                translation,
              },
            ),
          ),
        ),
      ].separated(const Gap()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:languages/models/app_model.dart';
import 'package:languages/models/dictionary.dart' as dictionary_model;
import 'package:languages/routes/dictionary/components/translation_field.dart';
import 'package:micha_core/micha_core.dart';

class Dictionary extends StatefulWidget {
  const Dictionary({super.key});

  @override
  State<Dictionary> createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  dictionary_model.Dictionary get dictionary =>
      GetIt.I<AppModel>().activeDictionary;
  set dictionary(dictionary_model.Dictionary value) =>
      GetIt.I<AppModel>().activeDictionary = value;

  void _speak(String phrase) {}

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TranslationField(
          originLanguage: dictionary.languages.origin,
          targetLanguage: dictionary.languages.target,
          addTranslation: (translation) => setState(
            () => dictionary = dictionary.copyWith(
              translations: {
                ...dictionary.translations,
                translation,
              },
            ),
          ),
        ),
        for (final translation in dictionary.translations)
          ListTile(
            key: ValueKey(translation),
            title: Text(translation.targetPhrase),
            subtitle: Text(translation.originPhrase),
            leading: IconButton(
              onPressed: () => _speak(translation.targetPhrase),
              icon: const Icon(Icons.volume_up),
            ),
            trailing: IconButton(
              onPressed: () => setState(
                () => dictionary = dictionary.copyWith(
                  translations: dictionary.translations
                      .where((item) => item != translation)
                      .toSet(),
                ),
              ),
              icon: const Icon(Icons.delete),
            ),
          ),
      ].separated(const Gap()),
    );
  }
}

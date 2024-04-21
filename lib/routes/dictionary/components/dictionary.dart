import 'package:flutter/material.dart';
import 'package:languages/models/dictionary.dart' as dictionary_model;
import 'package:languages/models/language.dart';
import 'package:languages/routes/dictionary/components/translation_field.dart';
import 'package:micha_core/micha_core.dart';

class Dictionary extends StatefulWidget {
  const Dictionary({super.key});

  @override
  State<Dictionary> createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  late dictionary_model.Dictionary dictionary;

  @override
  void initState() {
    super.initState();

    dictionary = dictionary_model.Dictionary(
      originLanguage: Language.german,
      targetLanguage: Language.russian,
      translations: Set.unmodifiable({}),
    );
  }

  void _speak(String phrase) {}

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TranslationField(
          originLanguage: dictionary.originLanguage,
          targetLanguage: dictionary.targetLanguage,
          addTranslation: (translation) {
            setState(
              () => dictionary = dictionary.copyWith(
                translations: Set.unmodifiable({
                  ...dictionary.translations,
                  translation,
                }),
              ),
            );
          },
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
              onPressed: () => setState(() {
                dictionary = dictionary.copyWith(
                  translations: Set.unmodifiable(
                    dictionary.translations
                        .where((item) => item != translation),
                  ),
                );
              }),
              icon: const Icon(Icons.delete),
            ),
          ),
      ].separated(const Gap()),
    );
  }
}

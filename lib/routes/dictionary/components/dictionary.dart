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
      translations: Map.unmodifiable({}),
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
          addTranslation: (originPhrase, targetPhrase) {
            setState(
              () => dictionary = dictionary.copyWith(
                translations: Map.unmodifiable({
                  ...dictionary.translations,
                  originPhrase: targetPhrase,
                }),
              ),
            );
          },
        ),
        for (final translation in dictionary.translations.entries)
          ListTile(
            key: ValueKey(translation),
            title: Text(translation.value),
            subtitle: Text(translation.key),
            leading: IconButton(
              onPressed: () => _speak(translation.value),
              icon: const Icon(Icons.volume_up),
            ),
            trailing: IconButton(
              onPressed: () => setState(() {
                dictionary = dictionary.copyWith(
                  translations: Map.unmodifiable(
                    {...dictionary.translations}..remove(translation.key),
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

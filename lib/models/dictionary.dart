import 'package:languages/models/language.dart';

class Dictionary {
  final Language originLanguage;
  final Language targetLanguage;
  final Map<String, String> translations;

  const Dictionary({
    required this.originLanguage,
    required this.targetLanguage,
    required this.translations,
  });

  Dictionary copyWith({
    Language? originLanguage,
    Language? targetLanguage,
    Map<String, String>? translations,
  }) =>
      Dictionary(
        originLanguage: originLanguage ?? this.originLanguage,
        targetLanguage: targetLanguage ?? this.targetLanguage,
        translations: translations ?? this.translations,
      );
}

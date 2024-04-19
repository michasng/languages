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
    Language? originLanguageCode,
    Language? targetLanguageCode,
    Map<String, String>? translations,
  }) =>
      Dictionary(
        originLanguage: originLanguageCode ?? originLanguage,
        targetLanguage: targetLanguageCode ?? targetLanguage,
        translations: translations ?? this.translations,
      );
}

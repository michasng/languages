import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:languages/models/language.dart';
import 'package:languages/models/translation.dart';

part 'dictionary.freezed.dart';
part 'dictionary.g.dart';

@freezed
class Dictionary with _$Dictionary {
  const factory Dictionary({
    required LanguagePair languages,
    required Set<Translation> translations,
  }) = _Dictionary;

  factory Dictionary.fromJson(Map<String, dynamic> json) =>
      _$DictionaryFromJson(json);
}

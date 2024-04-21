import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:languages/models/dictionary.dart';
import 'package:languages/models/language.dart';

part 'app_model.freezed.dart';

@unfreezed
class AppModel with _$AppModel {
  AppModel._();

  factory AppModel({
    required LanguagePair languages,
    required Set<Dictionary> dictionaries,
  }) = _AppModel;

  Dictionary get activeDictionary => dictionaries.firstWhere(
        (item) => item.languages == languages,
        orElse: () => Dictionary(
          languages: languages,
          translations: {},
        ),
      );

  set activeDictionary(Dictionary value) => dictionaries = {
        ...dictionaries.where((item) => item.languages != value.languages),
        value,
      };
}

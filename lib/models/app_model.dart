import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:languages/models/dictionary.dart';
import 'package:languages/models/game/emoji.dart';
import 'package:languages/models/language.dart';
import 'package:languages/models/to_json.dart';

part 'app_model.freezed.dart';
part 'app_model.g.dart';

@freezed
class AppModel with _$AppModel implements ToJson {
  AppModel._();

  factory AppModel({
    required LanguagePair languages,
    required Set<Emoji> emojis,
    required Set<Dictionary> dictionaries,
  }) = _AppModel;

  Dictionary get activeDictionary => dictionaries.firstWhere(
        (item) => item.languages == languages,
        orElse: () => Dictionary(
          languages: languages,
          translations: {},
        ),
      );

  Iterable<Dictionary> get inactiveDictionaries =>
      dictionaries.where((item) => item.languages != languages);

  factory AppModel.fromJson(Map<String, dynamic> json) =>
      _$AppModelFromJson(json);
}

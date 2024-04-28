import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:languages/models/language.dart';
import 'package:languages/models/term.dart';
import 'package:languages/models/to_json.dart';

part 'app_model.freezed.dart';
part 'app_model.g.dart';

@freezed
class AppModel with _$AppModel implements ToJson {
  AppModel._();

  factory AppModel({
    required LanguagePair languages,
    required Set<Term> terms,
  }) = _AppModel;

  factory AppModel.fromJson(Map<String, dynamic> json) =>
      _$AppModelFromJson(json);
}

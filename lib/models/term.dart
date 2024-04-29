import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:languages/models/category.dart';
import 'package:languages/models/translated.dart';

part 'term.freezed.dart';
part 'term.g.dart';

@freezed
class Term with _$Term implements Translated {
  const factory Term({
    required String origin,
    required String target,
    required Category category,
    String? assetPath,
  }) = _Term;

  factory Term.fromJson(Map<String, dynamic> json) => _$TermFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:languages/models/translated.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class Category with _$Category implements Translated {
  const factory Category({
    required String origin,
    required String target,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

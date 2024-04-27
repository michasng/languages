import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:languages/models/translation.dart';

part 'emoji.freezed.dart';
part 'emoji.g.dart';

@freezed
class Emoji with _$Emoji {
  const factory Emoji({
    required String assetPath,
    required Translation name,
  }) = _Emoji;

  factory Emoji.fromJson(Map<String, dynamic> json) => _$EmojiFromJson(json);
}

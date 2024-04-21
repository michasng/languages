import 'package:freezed_annotation/freezed_annotation.dart';

part 'translation.freezed.dart';

@freezed
class Translation with _$Translation {
  const factory Translation({
    required String originPhrase,
    required String targetPhrase,
  }) = _Translation;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'script.freezed.dart';

part 'script.g.dart';

@freezed
class Script with _$Script {
  const factory Script({
    @JsonKey(name: 'text') required String verse,
    @JsonKey(name: 'verse') required int verseNumber,
  }) = _Script;

  factory Script.fromJson(Map<String, Object?> json) => _$ScriptFromJson(json);
}
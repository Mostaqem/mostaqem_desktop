import 'package:freezed_annotation/freezed_annotation.dart';

part 'script.freezed.dart';

part 'script.g.dart';

@freezed
class Script with _$Script {
  const factory Script({
    required int id,
    @JsonKey(name: 'vers') required String verse,
    @JsonKey(name: 'verse_number') required int verseNumber,
  }) = _Script;

  factory Script.fromJson(Map<String, Object?> json) => _$ScriptFromJson(json);
}

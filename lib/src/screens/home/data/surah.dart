import 'package:freezed_annotation/freezed_annotation.dart';

part 'surah.freezed.dart';

part 'surah.g.dart';

@freezed
class Surah with _$Surah {
  const factory Surah({
    required int id,
    @JsonKey(name: 'name_simple') required String simpleName,
    @JsonKey(name: 'name_arabic') required String arabicName,
    @JsonKey(name: 'verses_count') int? versesCount,
  }) = _Surah;

  factory Surah.fromJson(Map<String, Object?> json) => _$SurahFromJson(json);
}

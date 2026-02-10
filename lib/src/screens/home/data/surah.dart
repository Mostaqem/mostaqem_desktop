import 'package:freezed_annotation/freezed_annotation.dart';

part 'surah.freezed.dart';

part 'surah.g.dart';

@Freezed(toJson: true)
abstract class Surah with _$Surah {
  const factory Surah({
    required int id,
    required String name,
    @JsonKey(name: 'makkia') required int revelationPlace,
  }) = _Surah;

  factory Surah.fromJson(Map<String, dynamic> json) => _$SurahFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'reciters_data.freezed.dart';

part 'reciters_data.g.dart';

@freezed
class Reciter with _$Reciter {
  const factory Reciter({
    required int id,
    @JsonKey(name: 'name_english') required String englishName,
    @JsonKey(name: 'name_arabic') required String arabicName,
    @Default(false) bool isDefault,
    String? image,
  }) = _Reciter;

  factory Reciter.fromJson(Map<String, Object?> json) =>
      _$ReciterFromJson(json);
}

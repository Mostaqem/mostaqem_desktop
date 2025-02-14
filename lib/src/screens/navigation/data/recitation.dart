import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';

part 'recitation.freezed.dart';
part 'recitation.g.dart';

@freezed
class Recitation with _$Recitation {
  const factory Recitation({
    required int id,
    required String name,
    Reciter? reciter,
    @JsonKey(name: 'name_english') String? englishName,
  }) = _Recitation;

  factory Recitation.fromJson(Map<String, Object?> json) =>
      _$RecitationFromJson(json);
}

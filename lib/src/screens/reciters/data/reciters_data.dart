import 'package:freezed_annotation/freezed_annotation.dart';

part 'reciters_data.freezed.dart';

part 'reciters_data.g.dart';

@freezed
abstract class Reciter with _$Reciter {
  const factory Reciter({
    required int id,
    required String name,
    required List<MoshafData> moshaf,
    @Default(false) bool isDefault,
  }) = _Reciter;

  factory Reciter.fromJson(Map<String, Object?> json) =>
      _$ReciterFromJson(json);
}

@freezed
abstract class MoshafData with _$MoshafData {
  const factory MoshafData({
    required int id,
    required String name,
    required String server,
  }) = _MoshafData;

  factory MoshafData.fromJson(Map<String, Object?> json) =>
      _$MoshafDataFromJson(json);
}

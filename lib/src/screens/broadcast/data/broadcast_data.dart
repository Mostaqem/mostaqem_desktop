
import 'package:freezed_annotation/freezed_annotation.dart';

part 'broadcast_data.freezed.dart';

part 'broadcast_data.g.dart';



@freezed
abstract class Broadcast with _$Broadcast {
  const factory Broadcast({
    required int id,
    required String name,
    required String url,
  }) = _Broadcast;

  factory Broadcast.fromJson(Map<String, Object?> json) =>
      _$BroadcastFromJson(json);
}

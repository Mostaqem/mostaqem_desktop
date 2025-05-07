// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broadcast_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Broadcast _$BroadcastFromJson(Map<String, dynamic> json) => _Broadcast(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$BroadcastToJson(_Broadcast instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
    };

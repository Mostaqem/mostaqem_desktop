// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Album _$AlbumFromJson(Map<String, dynamic> json) => _Album(
  surah: Surah.fromJson(json['surah'] as Map<String, dynamic>),
  reciter: Reciter.fromJson(json['reciter'] as Map<String, dynamic>),
  url: json['url'] as String,
  recitationID: (json['recitationID'] as num).toInt(),
  position: (json['position'] as num?)?.toInt() ?? 0,
  duration: (json['duration'] as num?)?.toInt() ?? 0,
  isLocal: json['isLocal'] as bool? ?? false,
);

Map<String, dynamic> _$AlbumToJson(_Album instance) => <String, dynamic>{
  'surah': instance.surah,
  'reciter': instance.reciter,
  'url': instance.url,
  'recitationID': instance.recitationID,
  'position': instance.position,
  'duration': instance.duration,
  'isLocal': instance.isLocal,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlbumImpl _$$AlbumImplFromJson(Map<String, dynamic> json) => _$AlbumImpl(
  surah: Surah.fromJson(json['surah'] as Map<String, dynamic>),
  reciter: Reciter.fromJson(json['reciter'] as Map<String, dynamic>),
  url: json['url'] as String,
  recitationID: (json['recitationID'] as num).toInt(),
  queueIndex: (json['queueIndex'] as num?)?.toInt(),
  position: (json['position'] as num?)?.toInt() ?? 0,
  duration: (json['duration'] as num?)?.toInt() ?? 0,
  isLocal: json['isLocal'] as bool? ?? false,
);

Map<String, dynamic> _$$AlbumImplToJson(_$AlbumImpl instance) =>
    <String, dynamic>{
      'surah': instance.surah,
      'reciter': instance.reciter,
      'url': instance.url,
      'recitationID': instance.recitationID,
      'queueIndex': instance.queueIndex,
      'position': instance.position,
      'duration': instance.duration,
      'isLocal': instance.isLocal,
    };

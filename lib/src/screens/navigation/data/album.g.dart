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
      position: (json['position'] as num?)?.toInt() ?? 0,
      isLocal: json['isLocal'] as bool? ?? false,
    );

Map<String, dynamic> _$$AlbumImplToJson(_$AlbumImpl instance) =>
    <String, dynamic>{
      'surah': instance.surah,
      'reciter': instance.reciter,
      'url': instance.url,
      'recitationID': instance.recitationID,
      'position': instance.position,
      'isLocal': instance.isLocal,
    };

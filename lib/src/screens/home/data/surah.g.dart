// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SurahImpl _$$SurahImplFromJson(Map<String, dynamic> json) => _$SurahImpl(
      id: (json['id'] as num).toInt(),
      simpleName: json['name_complex'] as String,
      arabicName: json['name_arabic'] as String,
      versesCount: (json['verses_count'] as num?)?.toInt(),
      revelationPlace: json['revelation_place'] as String,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$SurahImplToJson(_$SurahImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_complex': instance.simpleName,
      'name_arabic': instance.arabicName,
      'verses_count': instance.versesCount,
      'revelation_place': instance.revelationPlace,
      'image': instance.image,
    };

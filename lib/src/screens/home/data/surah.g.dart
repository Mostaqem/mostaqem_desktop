// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SurahImpl _$$SurahImplFromJson(Map<String, dynamic> json) => _$SurahImpl(
      id: (json['id'] as num).toInt(),
      simpleName: json['name_simple'] as String,
      arabicName: json['name_arabic'] as String,
      versesCount: (json['verses_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SurahImplToJson(_$SurahImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_simple': instance.simpleName,
      'name_arabic': instance.arabicName,
      'verses_count': instance.versesCount,
    };

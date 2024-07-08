// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reciters_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReciterImpl _$$ReciterImplFromJson(Map<String, dynamic> json) =>
    _$ReciterImpl(
      id: (json['id'] as num).toInt(),
      englishName: json['name_english'] as String,
      arabicName: json['name_arabic'] as String,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$ReciterImplToJson(_$ReciterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_english': instance.englishName,
      'name_arabic': instance.arabicName,
      'image': instance.image,
    };

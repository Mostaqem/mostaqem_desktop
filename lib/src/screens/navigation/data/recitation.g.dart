// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Recitation _$RecitationFromJson(Map<String, dynamic> json) => _Recitation(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  reciter:
      json['reciter'] == null
          ? null
          : Reciter.fromJson(json['reciter'] as Map<String, dynamic>),
  englishName: json['name_english'] as String?,
);

Map<String, dynamic> _$RecitationToJson(_Recitation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'reciter': instance.reciter,
      'name_english': instance.englishName,
    };

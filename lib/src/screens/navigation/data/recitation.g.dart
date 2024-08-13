// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecitationImpl _$$RecitationImplFromJson(Map<String, dynamic> json) =>
    _$RecitationImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      englishName: json['name_english'] as String?,
    );

Map<String, dynamic> _$$RecitationImplToJson(_$RecitationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_english': instance.englishName,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'script.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScriptImpl _$$ScriptImplFromJson(Map<String, dynamic> json) => _$ScriptImpl(
      id: (json['id'] as num).toInt(),
      verse: json['vers'] as String,
      verseNumber: (json['verse_number'] as num).toInt(),
    );

Map<String, dynamic> _$$ScriptImplToJson(_$ScriptImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vers': instance.verse,
      'verse_number': instance.verseNumber,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'script.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScriptImpl _$$ScriptImplFromJson(Map<String, dynamic> json) => _$ScriptImpl(
      verse: json['text'] as String,
      verseNumber: (json['verse'] as num).toInt(),
    );

Map<String, dynamic> _$$ScriptImplToJson(_$ScriptImpl instance) =>
    <String, dynamic>{
      'text': instance.verse,
      'verse': instance.verseNumber,
    };

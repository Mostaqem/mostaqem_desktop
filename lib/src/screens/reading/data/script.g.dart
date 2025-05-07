// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'script.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Script _$ScriptFromJson(Map<String, dynamic> json) => _Script(
  verse: json['text'] as String,
  verseNumber: (json['verse'] as num).toInt(),
);

Map<String, dynamic> _$ScriptToJson(_Script instance) => <String, dynamic>{
  'text': instance.verse,
  'verse': instance.verseNumber,
};

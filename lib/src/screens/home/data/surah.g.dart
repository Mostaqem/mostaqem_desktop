// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Surah _$SurahFromJson(Map<String, dynamic> json) => _Surah(
  id: (json['id'] as num).toInt(),
  simpleName: json['name_complex'] as String,
  arabicName: json['name_arabic'] as String,
  revelationPlace: json['revelation_place'] as String,
  versesCount: (json['verses_count'] as num?)?.toInt(),
  image: json['image'] as String?,
);

Map<String, dynamic> _$SurahToJson(_Surah instance) => <String, dynamic>{
  'id': instance.id,
  'name_complex': instance.simpleName,
  'name_arabic': instance.arabicName,
  'revelation_place': instance.revelationPlace,
  'verses_count': instance.versesCount,
  'image': instance.image,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reciters_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Reciter _$ReciterFromJson(Map<String, dynamic> json) => _Reciter(
  id: (json['id'] as num).toInt(),
  englishName: json['name_english'] as String,
  arabicName: json['name_arabic'] as String,
  isDefault: json['isDefault'] as bool? ?? false,
  image: json['image'] as String?,
);

Map<String, dynamic> _$ReciterToJson(_Reciter instance) => <String, dynamic>{
  'id': instance.id,
  'name_english': instance.englishName,
  'name_arabic': instance.arabicName,
  'isDefault': instance.isDefault,
  'image': instance.image,
};

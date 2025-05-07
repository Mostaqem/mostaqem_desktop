// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surah.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Surah {

 int get id;@JsonKey(name: 'name_complex') String get simpleName;@JsonKey(name: 'name_arabic') String get arabicName;@JsonKey(name: 'revelation_place') String get revelationPlace;@JsonKey(name: 'verses_count') int? get versesCount; String? get image;
/// Create a copy of Surah
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahCopyWith<Surah> get copyWith => _$SurahCopyWithImpl<Surah>(this as Surah, _$identity);

  /// Serializes this Surah to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Surah&&(identical(other.id, id) || other.id == id)&&(identical(other.simpleName, simpleName) || other.simpleName == simpleName)&&(identical(other.arabicName, arabicName) || other.arabicName == arabicName)&&(identical(other.revelationPlace, revelationPlace) || other.revelationPlace == revelationPlace)&&(identical(other.versesCount, versesCount) || other.versesCount == versesCount)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,simpleName,arabicName,revelationPlace,versesCount,image);

@override
String toString() {
  return 'Surah(id: $id, simpleName: $simpleName, arabicName: $arabicName, revelationPlace: $revelationPlace, versesCount: $versesCount, image: $image)';
}


}

/// @nodoc
abstract mixin class $SurahCopyWith<$Res>  {
  factory $SurahCopyWith(Surah value, $Res Function(Surah) _then) = _$SurahCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'name_complex') String simpleName,@JsonKey(name: 'name_arabic') String arabicName,@JsonKey(name: 'revelation_place') String revelationPlace,@JsonKey(name: 'verses_count') int? versesCount, String? image
});




}
/// @nodoc
class _$SurahCopyWithImpl<$Res>
    implements $SurahCopyWith<$Res> {
  _$SurahCopyWithImpl(this._self, this._then);

  final Surah _self;
  final $Res Function(Surah) _then;

/// Create a copy of Surah
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? simpleName = null,Object? arabicName = null,Object? revelationPlace = null,Object? versesCount = freezed,Object? image = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,simpleName: null == simpleName ? _self.simpleName : simpleName // ignore: cast_nullable_to_non_nullable
as String,arabicName: null == arabicName ? _self.arabicName : arabicName // ignore: cast_nullable_to_non_nullable
as String,revelationPlace: null == revelationPlace ? _self.revelationPlace : revelationPlace // ignore: cast_nullable_to_non_nullable
as String,versesCount: freezed == versesCount ? _self.versesCount : versesCount // ignore: cast_nullable_to_non_nullable
as int?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Surah implements Surah {
  const _Surah({required this.id, @JsonKey(name: 'name_complex') required this.simpleName, @JsonKey(name: 'name_arabic') required this.arabicName, @JsonKey(name: 'revelation_place') required this.revelationPlace, @JsonKey(name: 'verses_count') this.versesCount, this.image});
  factory _Surah.fromJson(Map<String, dynamic> json) => _$SurahFromJson(json);

@override final  int id;
@override@JsonKey(name: 'name_complex') final  String simpleName;
@override@JsonKey(name: 'name_arabic') final  String arabicName;
@override@JsonKey(name: 'revelation_place') final  String revelationPlace;
@override@JsonKey(name: 'verses_count') final  int? versesCount;
@override final  String? image;

/// Create a copy of Surah
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurahCopyWith<_Surah> get copyWith => __$SurahCopyWithImpl<_Surah>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurahToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Surah&&(identical(other.id, id) || other.id == id)&&(identical(other.simpleName, simpleName) || other.simpleName == simpleName)&&(identical(other.arabicName, arabicName) || other.arabicName == arabicName)&&(identical(other.revelationPlace, revelationPlace) || other.revelationPlace == revelationPlace)&&(identical(other.versesCount, versesCount) || other.versesCount == versesCount)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,simpleName,arabicName,revelationPlace,versesCount,image);

@override
String toString() {
  return 'Surah(id: $id, simpleName: $simpleName, arabicName: $arabicName, revelationPlace: $revelationPlace, versesCount: $versesCount, image: $image)';
}


}

/// @nodoc
abstract mixin class _$SurahCopyWith<$Res> implements $SurahCopyWith<$Res> {
  factory _$SurahCopyWith(_Surah value, $Res Function(_Surah) _then) = __$SurahCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'name_complex') String simpleName,@JsonKey(name: 'name_arabic') String arabicName,@JsonKey(name: 'revelation_place') String revelationPlace,@JsonKey(name: 'verses_count') int? versesCount, String? image
});




}
/// @nodoc
class __$SurahCopyWithImpl<$Res>
    implements _$SurahCopyWith<$Res> {
  __$SurahCopyWithImpl(this._self, this._then);

  final _Surah _self;
  final $Res Function(_Surah) _then;

/// Create a copy of Surah
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? simpleName = null,Object? arabicName = null,Object? revelationPlace = null,Object? versesCount = freezed,Object? image = freezed,}) {
  return _then(_Surah(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,simpleName: null == simpleName ? _self.simpleName : simpleName // ignore: cast_nullable_to_non_nullable
as String,arabicName: null == arabicName ? _self.arabicName : arabicName // ignore: cast_nullable_to_non_nullable
as String,revelationPlace: null == revelationPlace ? _self.revelationPlace : revelationPlace // ignore: cast_nullable_to_non_nullable
as String,versesCount: freezed == versesCount ? _self.versesCount : versesCount // ignore: cast_nullable_to_non_nullable
as int?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

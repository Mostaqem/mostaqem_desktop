// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reciters_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Reciter {

 int get id;@JsonKey(name: 'name_english') String get englishName;@JsonKey(name: 'name_arabic') String get arabicName; bool get isDefault; String? get image;
/// Create a copy of Reciter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReciterCopyWith<Reciter> get copyWith => _$ReciterCopyWithImpl<Reciter>(this as Reciter, _$identity);

  /// Serializes this Reciter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reciter&&(identical(other.id, id) || other.id == id)&&(identical(other.englishName, englishName) || other.englishName == englishName)&&(identical(other.arabicName, arabicName) || other.arabicName == arabicName)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,englishName,arabicName,isDefault,image);

@override
String toString() {
  return 'Reciter(id: $id, englishName: $englishName, arabicName: $arabicName, isDefault: $isDefault, image: $image)';
}


}

/// @nodoc
abstract mixin class $ReciterCopyWith<$Res>  {
  factory $ReciterCopyWith(Reciter value, $Res Function(Reciter) _then) = _$ReciterCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'name_english') String englishName,@JsonKey(name: 'name_arabic') String arabicName, bool isDefault, String? image
});




}
/// @nodoc
class _$ReciterCopyWithImpl<$Res>
    implements $ReciterCopyWith<$Res> {
  _$ReciterCopyWithImpl(this._self, this._then);

  final Reciter _self;
  final $Res Function(Reciter) _then;

/// Create a copy of Reciter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? englishName = null,Object? arabicName = null,Object? isDefault = null,Object? image = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,englishName: null == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String,arabicName: null == arabicName ? _self.arabicName : arabicName // ignore: cast_nullable_to_non_nullable
as String,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Reciter implements Reciter {
  const _Reciter({required this.id, @JsonKey(name: 'name_english') required this.englishName, @JsonKey(name: 'name_arabic') required this.arabicName, this.isDefault = false, this.image});
  factory _Reciter.fromJson(Map<String, dynamic> json) => _$ReciterFromJson(json);

@override final  int id;
@override@JsonKey(name: 'name_english') final  String englishName;
@override@JsonKey(name: 'name_arabic') final  String arabicName;
@override@JsonKey() final  bool isDefault;
@override final  String? image;

/// Create a copy of Reciter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReciterCopyWith<_Reciter> get copyWith => __$ReciterCopyWithImpl<_Reciter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReciterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reciter&&(identical(other.id, id) || other.id == id)&&(identical(other.englishName, englishName) || other.englishName == englishName)&&(identical(other.arabicName, arabicName) || other.arabicName == arabicName)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,englishName,arabicName,isDefault,image);

@override
String toString() {
  return 'Reciter(id: $id, englishName: $englishName, arabicName: $arabicName, isDefault: $isDefault, image: $image)';
}


}

/// @nodoc
abstract mixin class _$ReciterCopyWith<$Res> implements $ReciterCopyWith<$Res> {
  factory _$ReciterCopyWith(_Reciter value, $Res Function(_Reciter) _then) = __$ReciterCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'name_english') String englishName,@JsonKey(name: 'name_arabic') String arabicName, bool isDefault, String? image
});




}
/// @nodoc
class __$ReciterCopyWithImpl<$Res>
    implements _$ReciterCopyWith<$Res> {
  __$ReciterCopyWithImpl(this._self, this._then);

  final _Reciter _self;
  final $Res Function(_Reciter) _then;

/// Create a copy of Reciter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? englishName = null,Object? arabicName = null,Object? isDefault = null,Object? image = freezed,}) {
  return _then(_Reciter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,englishName: null == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String,arabicName: null == arabicName ? _self.arabicName : arabicName // ignore: cast_nullable_to_non_nullable
as String,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

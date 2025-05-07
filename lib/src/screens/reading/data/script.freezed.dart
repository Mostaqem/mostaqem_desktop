// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'script.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Script {

@JsonKey(name: 'text') String get verse;@JsonKey(name: 'verse') int get verseNumber;
/// Create a copy of Script
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScriptCopyWith<Script> get copyWith => _$ScriptCopyWithImpl<Script>(this as Script, _$identity);

  /// Serializes this Script to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Script&&(identical(other.verse, verse) || other.verse == verse)&&(identical(other.verseNumber, verseNumber) || other.verseNumber == verseNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,verse,verseNumber);

@override
String toString() {
  return 'Script(verse: $verse, verseNumber: $verseNumber)';
}


}

/// @nodoc
abstract mixin class $ScriptCopyWith<$Res>  {
  factory $ScriptCopyWith(Script value, $Res Function(Script) _then) = _$ScriptCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'text') String verse,@JsonKey(name: 'verse') int verseNumber
});




}
/// @nodoc
class _$ScriptCopyWithImpl<$Res>
    implements $ScriptCopyWith<$Res> {
  _$ScriptCopyWithImpl(this._self, this._then);

  final Script _self;
  final $Res Function(Script) _then;

/// Create a copy of Script
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? verse = null,Object? verseNumber = null,}) {
  return _then(_self.copyWith(
verse: null == verse ? _self.verse : verse // ignore: cast_nullable_to_non_nullable
as String,verseNumber: null == verseNumber ? _self.verseNumber : verseNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Script implements Script {
  const _Script({@JsonKey(name: 'text') required this.verse, @JsonKey(name: 'verse') required this.verseNumber});
  factory _Script.fromJson(Map<String, dynamic> json) => _$ScriptFromJson(json);

@override@JsonKey(name: 'text') final  String verse;
@override@JsonKey(name: 'verse') final  int verseNumber;

/// Create a copy of Script
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScriptCopyWith<_Script> get copyWith => __$ScriptCopyWithImpl<_Script>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScriptToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Script&&(identical(other.verse, verse) || other.verse == verse)&&(identical(other.verseNumber, verseNumber) || other.verseNumber == verseNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,verse,verseNumber);

@override
String toString() {
  return 'Script(verse: $verse, verseNumber: $verseNumber)';
}


}

/// @nodoc
abstract mixin class _$ScriptCopyWith<$Res> implements $ScriptCopyWith<$Res> {
  factory _$ScriptCopyWith(_Script value, $Res Function(_Script) _then) = __$ScriptCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'text') String verse,@JsonKey(name: 'verse') int verseNumber
});




}
/// @nodoc
class __$ScriptCopyWithImpl<$Res>
    implements _$ScriptCopyWith<$Res> {
  __$ScriptCopyWithImpl(this._self, this._then);

  final _Script _self;
  final $Res Function(_Script) _then;

/// Create a copy of Script
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? verse = null,Object? verseNumber = null,}) {
  return _then(_Script(
verse: null == verse ? _self.verse : verse // ignore: cast_nullable_to_non_nullable
as String,verseNumber: null == verseNumber ? _self.verseNumber : verseNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recitation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Recitation {

 int get id; String get name; Reciter? get reciter;@JsonKey(name: 'name_english') String? get englishName;
/// Create a copy of Recitation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecitationCopyWith<Recitation> get copyWith => _$RecitationCopyWithImpl<Recitation>(this as Recitation, _$identity);

  /// Serializes this Recitation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Recitation&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.reciter, reciter) || other.reciter == reciter)&&(identical(other.englishName, englishName) || other.englishName == englishName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,reciter,englishName);

@override
String toString() {
  return 'Recitation(id: $id, name: $name, reciter: $reciter, englishName: $englishName)';
}


}

/// @nodoc
abstract mixin class $RecitationCopyWith<$Res>  {
  factory $RecitationCopyWith(Recitation value, $Res Function(Recitation) _then) = _$RecitationCopyWithImpl;
@useResult
$Res call({
 int id, String name, Reciter? reciter,@JsonKey(name: 'name_english') String? englishName
});


$ReciterCopyWith<$Res>? get reciter;

}
/// @nodoc
class _$RecitationCopyWithImpl<$Res>
    implements $RecitationCopyWith<$Res> {
  _$RecitationCopyWithImpl(this._self, this._then);

  final Recitation _self;
  final $Res Function(Recitation) _then;

/// Create a copy of Recitation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? reciter = freezed,Object? englishName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,reciter: freezed == reciter ? _self.reciter : reciter // ignore: cast_nullable_to_non_nullable
as Reciter?,englishName: freezed == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Recitation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReciterCopyWith<$Res>? get reciter {
    if (_self.reciter == null) {
    return null;
  }

  return $ReciterCopyWith<$Res>(_self.reciter!, (value) {
    return _then(_self.copyWith(reciter: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _Recitation implements Recitation {
  const _Recitation({required this.id, required this.name, this.reciter, @JsonKey(name: 'name_english') this.englishName});
  factory _Recitation.fromJson(Map<String, dynamic> json) => _$RecitationFromJson(json);

@override final  int id;
@override final  String name;
@override final  Reciter? reciter;
@override@JsonKey(name: 'name_english') final  String? englishName;

/// Create a copy of Recitation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecitationCopyWith<_Recitation> get copyWith => __$RecitationCopyWithImpl<_Recitation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecitationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Recitation&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.reciter, reciter) || other.reciter == reciter)&&(identical(other.englishName, englishName) || other.englishName == englishName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,reciter,englishName);

@override
String toString() {
  return 'Recitation(id: $id, name: $name, reciter: $reciter, englishName: $englishName)';
}


}

/// @nodoc
abstract mixin class _$RecitationCopyWith<$Res> implements $RecitationCopyWith<$Res> {
  factory _$RecitationCopyWith(_Recitation value, $Res Function(_Recitation) _then) = __$RecitationCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, Reciter? reciter,@JsonKey(name: 'name_english') String? englishName
});


@override $ReciterCopyWith<$Res>? get reciter;

}
/// @nodoc
class __$RecitationCopyWithImpl<$Res>
    implements _$RecitationCopyWith<$Res> {
  __$RecitationCopyWithImpl(this._self, this._then);

  final _Recitation _self;
  final $Res Function(_Recitation) _then;

/// Create a copy of Recitation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? reciter = freezed,Object? englishName = freezed,}) {
  return _then(_Recitation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,reciter: freezed == reciter ? _self.reciter : reciter // ignore: cast_nullable_to_non_nullable
as Reciter?,englishName: freezed == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Recitation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReciterCopyWith<$Res>? get reciter {
    if (_self.reciter == null) {
    return null;
  }

  return $ReciterCopyWith<$Res>(_self.reciter!, (value) {
    return _then(_self.copyWith(reciter: value));
  });
}
}

// dart format on

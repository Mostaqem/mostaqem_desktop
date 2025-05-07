// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'broadcast_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Broadcast {

 int get id; String get name; String get url;
/// Create a copy of Broadcast
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BroadcastCopyWith<Broadcast> get copyWith => _$BroadcastCopyWithImpl<Broadcast>(this as Broadcast, _$identity);

  /// Serializes this Broadcast to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Broadcast&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,url);

@override
String toString() {
  return 'Broadcast(id: $id, name: $name, url: $url)';
}


}

/// @nodoc
abstract mixin class $BroadcastCopyWith<$Res>  {
  factory $BroadcastCopyWith(Broadcast value, $Res Function(Broadcast) _then) = _$BroadcastCopyWithImpl;
@useResult
$Res call({
 int id, String name, String url
});




}
/// @nodoc
class _$BroadcastCopyWithImpl<$Res>
    implements $BroadcastCopyWith<$Res> {
  _$BroadcastCopyWithImpl(this._self, this._then);

  final Broadcast _self;
  final $Res Function(Broadcast) _then;

/// Create a copy of Broadcast
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? url = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Broadcast implements Broadcast {
  const _Broadcast({required this.id, required this.name, required this.url});
  factory _Broadcast.fromJson(Map<String, dynamic> json) => _$BroadcastFromJson(json);

@override final  int id;
@override final  String name;
@override final  String url;

/// Create a copy of Broadcast
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BroadcastCopyWith<_Broadcast> get copyWith => __$BroadcastCopyWithImpl<_Broadcast>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BroadcastToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Broadcast&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,url);

@override
String toString() {
  return 'Broadcast(id: $id, name: $name, url: $url)';
}


}

/// @nodoc
abstract mixin class _$BroadcastCopyWith<$Res> implements $BroadcastCopyWith<$Res> {
  factory _$BroadcastCopyWith(_Broadcast value, $Res Function(_Broadcast) _then) = __$BroadcastCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String url
});




}
/// @nodoc
class __$BroadcastCopyWithImpl<$Res>
    implements _$BroadcastCopyWith<$Res> {
  __$BroadcastCopyWithImpl(this._self, this._then);

  final _Broadcast _self;
  final $Res Function(_Broadcast) _then;

/// Create a copy of Broadcast
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? url = null,}) {
  return _then(_Broadcast(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

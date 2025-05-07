// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'album.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Album {

 Surah get surah; Reciter get reciter; String get url; int get recitationID; int get position; int get duration; bool get isLocal;
/// Create a copy of Album
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlbumCopyWith<Album> get copyWith => _$AlbumCopyWithImpl<Album>(this as Album, _$identity);

  /// Serializes this Album to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Album&&(identical(other.surah, surah) || other.surah == surah)&&(identical(other.reciter, reciter) || other.reciter == reciter)&&(identical(other.url, url) || other.url == url)&&(identical(other.recitationID, recitationID) || other.recitationID == recitationID)&&(identical(other.position, position) || other.position == position)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.isLocal, isLocal) || other.isLocal == isLocal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surah,reciter,url,recitationID,position,duration,isLocal);

@override
String toString() {
  return 'Album(surah: $surah, reciter: $reciter, url: $url, recitationID: $recitationID, position: $position, duration: $duration, isLocal: $isLocal)';
}


}

/// @nodoc
abstract mixin class $AlbumCopyWith<$Res>  {
  factory $AlbumCopyWith(Album value, $Res Function(Album) _then) = _$AlbumCopyWithImpl;
@useResult
$Res call({
 Surah surah, Reciter reciter, String url, int recitationID, int position, int duration, bool isLocal
});


$SurahCopyWith<$Res> get surah;$ReciterCopyWith<$Res> get reciter;

}
/// @nodoc
class _$AlbumCopyWithImpl<$Res>
    implements $AlbumCopyWith<$Res> {
  _$AlbumCopyWithImpl(this._self, this._then);

  final Album _self;
  final $Res Function(Album) _then;

/// Create a copy of Album
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surah = null,Object? reciter = null,Object? url = null,Object? recitationID = null,Object? position = null,Object? duration = null,Object? isLocal = null,}) {
  return _then(_self.copyWith(
surah: null == surah ? _self.surah : surah // ignore: cast_nullable_to_non_nullable
as Surah,reciter: null == reciter ? _self.reciter : reciter // ignore: cast_nullable_to_non_nullable
as Reciter,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,recitationID: null == recitationID ? _self.recitationID : recitationID // ignore: cast_nullable_to_non_nullable
as int,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,isLocal: null == isLocal ? _self.isLocal : isLocal // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Album
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurahCopyWith<$Res> get surah {
  
  return $SurahCopyWith<$Res>(_self.surah, (value) {
    return _then(_self.copyWith(surah: value));
  });
}/// Create a copy of Album
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReciterCopyWith<$Res> get reciter {
  
  return $ReciterCopyWith<$Res>(_self.reciter, (value) {
    return _then(_self.copyWith(reciter: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _Album implements Album {
  const _Album({required this.surah, required this.reciter, required this.url, required this.recitationID, this.position = 0, this.duration = 0, this.isLocal = false});
  factory _Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

@override final  Surah surah;
@override final  Reciter reciter;
@override final  String url;
@override final  int recitationID;
@override@JsonKey() final  int position;
@override@JsonKey() final  int duration;
@override@JsonKey() final  bool isLocal;

/// Create a copy of Album
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlbumCopyWith<_Album> get copyWith => __$AlbumCopyWithImpl<_Album>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlbumToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Album&&(identical(other.surah, surah) || other.surah == surah)&&(identical(other.reciter, reciter) || other.reciter == reciter)&&(identical(other.url, url) || other.url == url)&&(identical(other.recitationID, recitationID) || other.recitationID == recitationID)&&(identical(other.position, position) || other.position == position)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.isLocal, isLocal) || other.isLocal == isLocal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surah,reciter,url,recitationID,position,duration,isLocal);

@override
String toString() {
  return 'Album(surah: $surah, reciter: $reciter, url: $url, recitationID: $recitationID, position: $position, duration: $duration, isLocal: $isLocal)';
}


}

/// @nodoc
abstract mixin class _$AlbumCopyWith<$Res> implements $AlbumCopyWith<$Res> {
  factory _$AlbumCopyWith(_Album value, $Res Function(_Album) _then) = __$AlbumCopyWithImpl;
@override @useResult
$Res call({
 Surah surah, Reciter reciter, String url, int recitationID, int position, int duration, bool isLocal
});


@override $SurahCopyWith<$Res> get surah;@override $ReciterCopyWith<$Res> get reciter;

}
/// @nodoc
class __$AlbumCopyWithImpl<$Res>
    implements _$AlbumCopyWith<$Res> {
  __$AlbumCopyWithImpl(this._self, this._then);

  final _Album _self;
  final $Res Function(_Album) _then;

/// Create a copy of Album
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surah = null,Object? reciter = null,Object? url = null,Object? recitationID = null,Object? position = null,Object? duration = null,Object? isLocal = null,}) {
  return _then(_Album(
surah: null == surah ? _self.surah : surah // ignore: cast_nullable_to_non_nullable
as Surah,reciter: null == reciter ? _self.reciter : reciter // ignore: cast_nullable_to_non_nullable
as Reciter,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,recitationID: null == recitationID ? _self.recitationID : recitationID // ignore: cast_nullable_to_non_nullable
as int,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,isLocal: null == isLocal ? _self.isLocal : isLocal // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Album
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurahCopyWith<$Res> get surah {
  
  return $SurahCopyWith<$Res>(_self.surah, (value) {
    return _then(_self.copyWith(surah: value));
  });
}/// Create a copy of Album
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReciterCopyWith<$Res> get reciter {
  
  return $ReciterCopyWith<$Res>(_self.reciter, (value) {
    return _then(_self.copyWith(reciter: value));
  });
}
}

// dart format on

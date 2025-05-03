// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'album.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Album _$AlbumFromJson(Map<String, dynamic> json) {
  return _Album.fromJson(json);
}

/// @nodoc
mixin _$Album {
  Surah get surah => throw _privateConstructorUsedError;
  Reciter get reciter => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  int get recitationID => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  bool get isLocal => throw _privateConstructorUsedError;

  /// Serializes this Album to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlbumCopyWith<Album> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlbumCopyWith<$Res> {
  factory $AlbumCopyWith(Album value, $Res Function(Album) then) =
      _$AlbumCopyWithImpl<$Res, Album>;
  @useResult
  $Res call({
    Surah surah,
    Reciter reciter,
    String url,
    int recitationID,
    int position,
    int duration,
    bool isLocal,
  });

  $SurahCopyWith<$Res> get surah;
  $ReciterCopyWith<$Res> get reciter;
}

/// @nodoc
class _$AlbumCopyWithImpl<$Res, $Val extends Album>
    implements $AlbumCopyWith<$Res> {
  _$AlbumCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? surah = null,
    Object? reciter = null,
    Object? url = null,
    Object? recitationID = null,
    Object? position = null,
    Object? duration = null,
    Object? isLocal = null,
  }) {
    return _then(
      _value.copyWith(
            surah:
                null == surah
                    ? _value.surah
                    : surah // ignore: cast_nullable_to_non_nullable
                        as Surah,
            reciter:
                null == reciter
                    ? _value.reciter
                    : reciter // ignore: cast_nullable_to_non_nullable
                        as Reciter,
            url:
                null == url
                    ? _value.url
                    : url // ignore: cast_nullable_to_non_nullable
                        as String,
            recitationID:
                null == recitationID
                    ? _value.recitationID
                    : recitationID // ignore: cast_nullable_to_non_nullable
                        as int,
            position:
                null == position
                    ? _value.position
                    : position // ignore: cast_nullable_to_non_nullable
                        as int,
            duration:
                null == duration
                    ? _value.duration
                    : duration // ignore: cast_nullable_to_non_nullable
                        as int,
            isLocal:
                null == isLocal
                    ? _value.isLocal
                    : isLocal // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SurahCopyWith<$Res> get surah {
    return $SurahCopyWith<$Res>(_value.surah, (value) {
      return _then(_value.copyWith(surah: value) as $Val);
    });
  }

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReciterCopyWith<$Res> get reciter {
    return $ReciterCopyWith<$Res>(_value.reciter, (value) {
      return _then(_value.copyWith(reciter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AlbumImplCopyWith<$Res> implements $AlbumCopyWith<$Res> {
  factory _$$AlbumImplCopyWith(
    _$AlbumImpl value,
    $Res Function(_$AlbumImpl) then,
  ) = __$$AlbumImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Surah surah,
    Reciter reciter,
    String url,
    int recitationID,
    int position,
    int duration,
    bool isLocal,
  });

  @override
  $SurahCopyWith<$Res> get surah;
  @override
  $ReciterCopyWith<$Res> get reciter;
}

/// @nodoc
class __$$AlbumImplCopyWithImpl<$Res>
    extends _$AlbumCopyWithImpl<$Res, _$AlbumImpl>
    implements _$$AlbumImplCopyWith<$Res> {
  __$$AlbumImplCopyWithImpl(
    _$AlbumImpl _value,
    $Res Function(_$AlbumImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? surah = null,
    Object? reciter = null,
    Object? url = null,
    Object? recitationID = null,
    Object? position = null,
    Object? duration = null,
    Object? isLocal = null,
  }) {
    return _then(
      _$AlbumImpl(
        surah:
            null == surah
                ? _value.surah
                : surah // ignore: cast_nullable_to_non_nullable
                    as Surah,
        reciter:
            null == reciter
                ? _value.reciter
                : reciter // ignore: cast_nullable_to_non_nullable
                    as Reciter,
        url:
            null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                    as String,
        recitationID:
            null == recitationID
                ? _value.recitationID
                : recitationID // ignore: cast_nullable_to_non_nullable
                    as int,
        position:
            null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                    as int,
        duration:
            null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                    as int,
        isLocal:
            null == isLocal
                ? _value.isLocal
                : isLocal // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AlbumImpl implements _Album {
  const _$AlbumImpl({
    required this.surah,
    required this.reciter,
    required this.url,
    required this.recitationID,
    this.position = 0,
    this.duration = 0,
    this.isLocal = false,
  });

  factory _$AlbumImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlbumImplFromJson(json);

  @override
  final Surah surah;
  @override
  final Reciter reciter;
  @override
  final String url;
  @override
  final int recitationID;
  @override
  @JsonKey()
  final int position;
  @override
  @JsonKey()
  final int duration;
  @override
  @JsonKey()
  final bool isLocal;

  @override
  String toString() {
    return 'Album(surah: $surah, reciter: $reciter, url: $url, recitationID: $recitationID, position: $position, duration: $duration, isLocal: $isLocal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlbumImpl &&
            (identical(other.surah, surah) || other.surah == surah) &&
            (identical(other.reciter, reciter) || other.reciter == reciter) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.recitationID, recitationID) ||
                other.recitationID == recitationID) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.isLocal, isLocal) || other.isLocal == isLocal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    surah,
    reciter,
    url,
    recitationID,
    position,
    duration,
    isLocal,
  );

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlbumImplCopyWith<_$AlbumImpl> get copyWith =>
      __$$AlbumImplCopyWithImpl<_$AlbumImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlbumImplToJson(this);
  }
}

abstract class _Album implements Album {
  const factory _Album({
    required final Surah surah,
    required final Reciter reciter,
    required final String url,
    required final int recitationID,
    final int position,
    final int duration,
    final bool isLocal,
  }) = _$AlbumImpl;

  factory _Album.fromJson(Map<String, dynamic> json) = _$AlbumImpl.fromJson;

  @override
  Surah get surah;
  @override
  Reciter get reciter;
  @override
  String get url;
  @override
  int get recitationID;
  @override
  int get position;
  @override
  int get duration;
  @override
  bool get isLocal;

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlbumImplCopyWith<_$AlbumImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

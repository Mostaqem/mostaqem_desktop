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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Album _$AlbumFromJson(Map<String, dynamic> json) {
  return _Album.fromJson(json);
}

/// @nodoc
mixin _$Album {
  Surah get surah => throw _privateConstructorUsedError;
  Reciter get reciter => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlbumCopyWith<Album> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlbumCopyWith<$Res> {
  factory $AlbumCopyWith(Album value, $Res Function(Album) then) =
      _$AlbumCopyWithImpl<$Res, Album>;
  @useResult
  $Res call({Surah surah, Reciter reciter, int position, String url});

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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? surah = null,
    Object? reciter = null,
    Object? position = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      surah: null == surah
          ? _value.surah
          : surah // ignore: cast_nullable_to_non_nullable
              as Surah,
      reciter: null == reciter
          ? _value.reciter
          : reciter // ignore: cast_nullable_to_non_nullable
              as Reciter,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SurahCopyWith<$Res> get surah {
    return $SurahCopyWith<$Res>(_value.surah, (value) {
      return _then(_value.copyWith(surah: value) as $Val);
    });
  }

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
          _$AlbumImpl value, $Res Function(_$AlbumImpl) then) =
      __$$AlbumImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Surah surah, Reciter reciter, int position, String url});

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
      _$AlbumImpl _value, $Res Function(_$AlbumImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? surah = null,
    Object? reciter = null,
    Object? position = null,
    Object? url = null,
  }) {
    return _then(_$AlbumImpl(
      surah: null == surah
          ? _value.surah
          : surah // ignore: cast_nullable_to_non_nullable
              as Surah,
      reciter: null == reciter
          ? _value.reciter
          : reciter // ignore: cast_nullable_to_non_nullable
              as Reciter,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlbumImpl implements _Album {
  const _$AlbumImpl(
      {required this.surah,
      required this.reciter,
      this.position = 0,
      required this.url});

  factory _$AlbumImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlbumImplFromJson(json);

  @override
  final Surah surah;
  @override
  final Reciter reciter;
  @override
  @JsonKey()
  final int position;
  @override
  final String url;

  @override
  String toString() {
    return 'Album(surah: $surah, reciter: $reciter, position: $position, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlbumImpl &&
            (identical(other.surah, surah) || other.surah == surah) &&
            (identical(other.reciter, reciter) || other.reciter == reciter) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, surah, reciter, position, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlbumImplCopyWith<_$AlbumImpl> get copyWith =>
      __$$AlbumImplCopyWithImpl<_$AlbumImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlbumImplToJson(
      this,
    );
  }
}

abstract class _Album implements Album {
  const factory _Album(
      {required final Surah surah,
      required final Reciter reciter,
      final int position,
      required final String url}) = _$AlbumImpl;

  factory _Album.fromJson(Map<String, dynamic> json) = _$AlbumImpl.fromJson;

  @override
  Surah get surah;
  @override
  Reciter get reciter;
  @override
  int get position;
  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$AlbumImplCopyWith<_$AlbumImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

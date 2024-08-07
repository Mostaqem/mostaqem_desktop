// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surah.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Surah _$SurahFromJson(Map<String, dynamic> json) {
  return _Surah.fromJson(json);
}

/// @nodoc
mixin _$Surah {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_complex')
  String get simpleName => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_arabic')
  String get arabicName => throw _privateConstructorUsedError;
  @JsonKey(name: 'revelation_place')
  String get revelationPlace => throw _privateConstructorUsedError;
  @JsonKey(name: 'verses_count')
  int? get versesCount => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;

  /// Serializes this Surah to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Surah
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SurahCopyWith<Surah> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SurahCopyWith<$Res> {
  factory $SurahCopyWith(Surah value, $Res Function(Surah) then) =
      _$SurahCopyWithImpl<$Res, Surah>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'name_complex') String simpleName,
      @JsonKey(name: 'name_arabic') String arabicName,
      @JsonKey(name: 'revelation_place') String revelationPlace,
      @JsonKey(name: 'verses_count') int? versesCount,
      String? image});
}

/// @nodoc
class _$SurahCopyWithImpl<$Res, $Val extends Surah>
    implements $SurahCopyWith<$Res> {
  _$SurahCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Surah
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? simpleName = null,
    Object? arabicName = null,
    Object? revelationPlace = null,
    Object? versesCount = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      simpleName: null == simpleName
          ? _value.simpleName
          : simpleName // ignore: cast_nullable_to_non_nullable
              as String,
      arabicName: null == arabicName
          ? _value.arabicName
          : arabicName // ignore: cast_nullable_to_non_nullable
              as String,
      revelationPlace: null == revelationPlace
          ? _value.revelationPlace
          : revelationPlace // ignore: cast_nullable_to_non_nullable
              as String,
      versesCount: freezed == versesCount
          ? _value.versesCount
          : versesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SurahImplCopyWith<$Res> implements $SurahCopyWith<$Res> {
  factory _$$SurahImplCopyWith(
          _$SurahImpl value, $Res Function(_$SurahImpl) then) =
      __$$SurahImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'name_complex') String simpleName,
      @JsonKey(name: 'name_arabic') String arabicName,
      @JsonKey(name: 'revelation_place') String revelationPlace,
      @JsonKey(name: 'verses_count') int? versesCount,
      String? image});
}

/// @nodoc
class __$$SurahImplCopyWithImpl<$Res>
    extends _$SurahCopyWithImpl<$Res, _$SurahImpl>
    implements _$$SurahImplCopyWith<$Res> {
  __$$SurahImplCopyWithImpl(
      _$SurahImpl _value, $Res Function(_$SurahImpl) _then)
      : super(_value, _then);

  /// Create a copy of Surah
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? simpleName = null,
    Object? arabicName = null,
    Object? revelationPlace = null,
    Object? versesCount = freezed,
    Object? image = freezed,
  }) {
    return _then(_$SurahImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      simpleName: null == simpleName
          ? _value.simpleName
          : simpleName // ignore: cast_nullable_to_non_nullable
              as String,
      arabicName: null == arabicName
          ? _value.arabicName
          : arabicName // ignore: cast_nullable_to_non_nullable
              as String,
      revelationPlace: null == revelationPlace
          ? _value.revelationPlace
          : revelationPlace // ignore: cast_nullable_to_non_nullable
              as String,
      versesCount: freezed == versesCount
          ? _value.versesCount
          : versesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SurahImpl implements _Surah {
  const _$SurahImpl(
      {required this.id,
      @JsonKey(name: 'name_complex') required this.simpleName,
      @JsonKey(name: 'name_arabic') required this.arabicName,
      @JsonKey(name: 'revelation_place') required this.revelationPlace,
      @JsonKey(name: 'verses_count') this.versesCount,
      this.image});

  factory _$SurahImpl.fromJson(Map<String, dynamic> json) =>
      _$$SurahImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'name_complex')
  final String simpleName;
  @override
  @JsonKey(name: 'name_arabic')
  final String arabicName;
  @override
  @JsonKey(name: 'revelation_place')
  final String revelationPlace;
  @override
  @JsonKey(name: 'verses_count')
  final int? versesCount;
  @override
  final String? image;

  @override
  String toString() {
    return 'Surah(id: $id, simpleName: $simpleName, arabicName: $arabicName, revelationPlace: $revelationPlace, versesCount: $versesCount, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SurahImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.simpleName, simpleName) ||
                other.simpleName == simpleName) &&
            (identical(other.arabicName, arabicName) ||
                other.arabicName == arabicName) &&
            (identical(other.revelationPlace, revelationPlace) ||
                other.revelationPlace == revelationPlace) &&
            (identical(other.versesCount, versesCount) ||
                other.versesCount == versesCount) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, simpleName, arabicName,
      revelationPlace, versesCount, image);

  /// Create a copy of Surah
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SurahImplCopyWith<_$SurahImpl> get copyWith =>
      __$$SurahImplCopyWithImpl<_$SurahImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SurahImplToJson(
      this,
    );
  }
}

abstract class _Surah implements Surah {
  const factory _Surah(
      {required final int id,
      @JsonKey(name: 'name_complex') required final String simpleName,
      @JsonKey(name: 'name_arabic') required final String arabicName,
      @JsonKey(name: 'revelation_place') required final String revelationPlace,
      @JsonKey(name: 'verses_count') final int? versesCount,
      final String? image}) = _$SurahImpl;

  factory _Surah.fromJson(Map<String, dynamic> json) = _$SurahImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'name_complex')
  String get simpleName;
  @override
  @JsonKey(name: 'name_arabic')
  String get arabicName;
  @override
  @JsonKey(name: 'revelation_place')
  String get revelationPlace;
  @override
  @JsonKey(name: 'verses_count')
  int? get versesCount;
  @override
  String? get image;

  /// Create a copy of Surah
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SurahImplCopyWith<_$SurahImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

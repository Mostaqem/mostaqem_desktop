// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reciters_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Reciter _$ReciterFromJson(Map<String, dynamic> json) {
  return _Reciter.fromJson(json);
}

/// @nodoc
mixin _$Reciter {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_english')
  String get englishName => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_arabic')
  String get arabicName => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReciterCopyWith<Reciter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReciterCopyWith<$Res> {
  factory $ReciterCopyWith(Reciter value, $Res Function(Reciter) then) =
      _$ReciterCopyWithImpl<$Res, Reciter>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'name_english') String englishName,
      @JsonKey(name: 'name_arabic') String arabicName,
      String? image});
}

/// @nodoc
class _$ReciterCopyWithImpl<$Res, $Val extends Reciter>
    implements $ReciterCopyWith<$Res> {
  _$ReciterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? englishName = null,
    Object? arabicName = null,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      englishName: null == englishName
          ? _value.englishName
          : englishName // ignore: cast_nullable_to_non_nullable
              as String,
      arabicName: null == arabicName
          ? _value.arabicName
          : arabicName // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReciterImplCopyWith<$Res> implements $ReciterCopyWith<$Res> {
  factory _$$ReciterImplCopyWith(
          _$ReciterImpl value, $Res Function(_$ReciterImpl) then) =
      __$$ReciterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'name_english') String englishName,
      @JsonKey(name: 'name_arabic') String arabicName,
      String? image});
}

/// @nodoc
class __$$ReciterImplCopyWithImpl<$Res>
    extends _$ReciterCopyWithImpl<$Res, _$ReciterImpl>
    implements _$$ReciterImplCopyWith<$Res> {
  __$$ReciterImplCopyWithImpl(
      _$ReciterImpl _value, $Res Function(_$ReciterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? englishName = null,
    Object? arabicName = null,
    Object? image = freezed,
  }) {
    return _then(_$ReciterImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      englishName: null == englishName
          ? _value.englishName
          : englishName // ignore: cast_nullable_to_non_nullable
              as String,
      arabicName: null == arabicName
          ? _value.arabicName
          : arabicName // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReciterImpl implements _Reciter {
  const _$ReciterImpl(
      {required this.id,
      @JsonKey(name: 'name_english') required this.englishName,
      @JsonKey(name: 'name_arabic') required this.arabicName,
      this.image});

  factory _$ReciterImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReciterImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'name_english')
  final String englishName;
  @override
  @JsonKey(name: 'name_arabic')
  final String arabicName;
  @override
  final String? image;

  @override
  String toString() {
    return 'Reciter(id: $id, englishName: $englishName, arabicName: $arabicName, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReciterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.englishName, englishName) ||
                other.englishName == englishName) &&
            (identical(other.arabicName, arabicName) ||
                other.arabicName == arabicName) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, englishName, arabicName, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReciterImplCopyWith<_$ReciterImpl> get copyWith =>
      __$$ReciterImplCopyWithImpl<_$ReciterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReciterImplToJson(
      this,
    );
  }
}

abstract class _Reciter implements Reciter {
  const factory _Reciter(
      {required final int id,
      @JsonKey(name: 'name_english') required final String englishName,
      @JsonKey(name: 'name_arabic') required final String arabicName,
      final String? image}) = _$ReciterImpl;

  factory _Reciter.fromJson(Map<String, dynamic> json) = _$ReciterImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'name_english')
  String get englishName;
  @override
  @JsonKey(name: 'name_arabic')
  String get arabicName;
  @override
  String? get image;
  @override
  @JsonKey(ignore: true)
  _$$ReciterImplCopyWith<_$ReciterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

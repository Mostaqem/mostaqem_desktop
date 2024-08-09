// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'script.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Script _$ScriptFromJson(Map<String, dynamic> json) {
  return _Script.fromJson(json);
}

/// @nodoc
mixin _$Script {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'vers')
  String get verse => throw _privateConstructorUsedError;
  @JsonKey(name: 'verse_number')
  int get verseNumber => throw _privateConstructorUsedError;

  /// Serializes this Script to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Script
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScriptCopyWith<Script> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScriptCopyWith<$Res> {
  factory $ScriptCopyWith(Script value, $Res Function(Script) then) =
      _$ScriptCopyWithImpl<$Res, Script>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'vers') String verse,
      @JsonKey(name: 'verse_number') int verseNumber});
}

/// @nodoc
class _$ScriptCopyWithImpl<$Res, $Val extends Script>
    implements $ScriptCopyWith<$Res> {
  _$ScriptCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Script
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? verse = null,
    Object? verseNumber = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      verse: null == verse
          ? _value.verse
          : verse // ignore: cast_nullable_to_non_nullable
              as String,
      verseNumber: null == verseNumber
          ? _value.verseNumber
          : verseNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScriptImplCopyWith<$Res> implements $ScriptCopyWith<$Res> {
  factory _$$ScriptImplCopyWith(
          _$ScriptImpl value, $Res Function(_$ScriptImpl) then) =
      __$$ScriptImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'vers') String verse,
      @JsonKey(name: 'verse_number') int verseNumber});
}

/// @nodoc
class __$$ScriptImplCopyWithImpl<$Res>
    extends _$ScriptCopyWithImpl<$Res, _$ScriptImpl>
    implements _$$ScriptImplCopyWith<$Res> {
  __$$ScriptImplCopyWithImpl(
      _$ScriptImpl _value, $Res Function(_$ScriptImpl) _then)
      : super(_value, _then);

  /// Create a copy of Script
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? verse = null,
    Object? verseNumber = null,
  }) {
    return _then(_$ScriptImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      verse: null == verse
          ? _value.verse
          : verse // ignore: cast_nullable_to_non_nullable
              as String,
      verseNumber: null == verseNumber
          ? _value.verseNumber
          : verseNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScriptImpl implements _Script {
  const _$ScriptImpl(
      {required this.id,
      @JsonKey(name: 'vers') required this.verse,
      @JsonKey(name: 'verse_number') required this.verseNumber});

  factory _$ScriptImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScriptImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'vers')
  final String verse;
  @override
  @JsonKey(name: 'verse_number')
  final int verseNumber;

  @override
  String toString() {
    return 'Script(id: $id, verse: $verse, verseNumber: $verseNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScriptImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.verse, verse) || other.verse == verse) &&
            (identical(other.verseNumber, verseNumber) ||
                other.verseNumber == verseNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, verse, verseNumber);

  /// Create a copy of Script
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScriptImplCopyWith<_$ScriptImpl> get copyWith =>
      __$$ScriptImplCopyWithImpl<_$ScriptImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScriptImplToJson(
      this,
    );
  }
}

abstract class _Script implements Script {
  const factory _Script(
          {required final int id,
          @JsonKey(name: 'vers') required final String verse,
          @JsonKey(name: 'verse_number') required final int verseNumber}) =
      _$ScriptImpl;

  factory _Script.fromJson(Map<String, dynamic> json) = _$ScriptImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'vers')
  String get verse;
  @override
  @JsonKey(name: 'verse_number')
  int get verseNumber;

  /// Create a copy of Script
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScriptImplCopyWith<_$ScriptImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

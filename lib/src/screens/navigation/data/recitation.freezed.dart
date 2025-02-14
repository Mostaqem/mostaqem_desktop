// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recitation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Recitation _$RecitationFromJson(Map<String, dynamic> json) {
  return _Recitation.fromJson(json);
}

/// @nodoc
mixin _$Recitation {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Reciter? get reciter => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_english')
  String? get englishName => throw _privateConstructorUsedError;

  /// Serializes this Recitation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Recitation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecitationCopyWith<Recitation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecitationCopyWith<$Res> {
  factory $RecitationCopyWith(
    Recitation value,
    $Res Function(Recitation) then,
  ) = _$RecitationCopyWithImpl<$Res, Recitation>;
  @useResult
  $Res call({
    int id,
    String name,
    Reciter? reciter,
    @JsonKey(name: 'name_english') String? englishName,
  });

  $ReciterCopyWith<$Res>? get reciter;
}

/// @nodoc
class _$RecitationCopyWithImpl<$Res, $Val extends Recitation>
    implements $RecitationCopyWith<$Res> {
  _$RecitationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Recitation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? reciter = freezed,
    Object? englishName = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            reciter:
                freezed == reciter
                    ? _value.reciter
                    : reciter // ignore: cast_nullable_to_non_nullable
                        as Reciter?,
            englishName:
                freezed == englishName
                    ? _value.englishName
                    : englishName // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Recitation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReciterCopyWith<$Res>? get reciter {
    if (_value.reciter == null) {
      return null;
    }

    return $ReciterCopyWith<$Res>(_value.reciter!, (value) {
      return _then(_value.copyWith(reciter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RecitationImplCopyWith<$Res>
    implements $RecitationCopyWith<$Res> {
  factory _$$RecitationImplCopyWith(
    _$RecitationImpl value,
    $Res Function(_$RecitationImpl) then,
  ) = __$$RecitationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    Reciter? reciter,
    @JsonKey(name: 'name_english') String? englishName,
  });

  @override
  $ReciterCopyWith<$Res>? get reciter;
}

/// @nodoc
class __$$RecitationImplCopyWithImpl<$Res>
    extends _$RecitationCopyWithImpl<$Res, _$RecitationImpl>
    implements _$$RecitationImplCopyWith<$Res> {
  __$$RecitationImplCopyWithImpl(
    _$RecitationImpl _value,
    $Res Function(_$RecitationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Recitation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? reciter = freezed,
    Object? englishName = freezed,
  }) {
    return _then(
      _$RecitationImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        reciter:
            freezed == reciter
                ? _value.reciter
                : reciter // ignore: cast_nullable_to_non_nullable
                    as Reciter?,
        englishName:
            freezed == englishName
                ? _value.englishName
                : englishName // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecitationImpl implements _Recitation {
  const _$RecitationImpl({
    required this.id,
    required this.name,
    this.reciter,
    @JsonKey(name: 'name_english') this.englishName,
  });

  factory _$RecitationImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecitationImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final Reciter? reciter;
  @override
  @JsonKey(name: 'name_english')
  final String? englishName;

  @override
  String toString() {
    return 'Recitation(id: $id, name: $name, reciter: $reciter, englishName: $englishName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecitationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.reciter, reciter) || other.reciter == reciter) &&
            (identical(other.englishName, englishName) ||
                other.englishName == englishName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, reciter, englishName);

  /// Create a copy of Recitation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecitationImplCopyWith<_$RecitationImpl> get copyWith =>
      __$$RecitationImplCopyWithImpl<_$RecitationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecitationImplToJson(this);
  }
}

abstract class _Recitation implements Recitation {
  const factory _Recitation({
    required final int id,
    required final String name,
    final Reciter? reciter,
    @JsonKey(name: 'name_english') final String? englishName,
  }) = _$RecitationImpl;

  factory _Recitation.fromJson(Map<String, dynamic> json) =
      _$RecitationImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  Reciter? get reciter;
  @override
  @JsonKey(name: 'name_english')
  String? get englishName;

  /// Create a copy of Recitation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecitationImplCopyWith<_$RecitationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

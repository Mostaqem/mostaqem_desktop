// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smtc_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$updateSMTCHash() => r'f04915b39f0d43e33980628163318a9c75abffc1';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [updateSMTC].
@ProviderFor(updateSMTC)
const updateSMTCProvider = UpdateSMTCFamily();

/// See also [updateSMTC].
class UpdateSMTCFamily extends Family<Object?> {
  /// See also [updateSMTC].
  const UpdateSMTCFamily();

  /// See also [updateSMTC].
  UpdateSMTCProvider call({
    required String surah,
    required String reciter,
    required String image,
  }) {
    return UpdateSMTCProvider(
      surah: surah,
      reciter: reciter,
      image: image,
    );
  }

  @override
  UpdateSMTCProvider getProviderOverride(
    covariant UpdateSMTCProvider provider,
  ) {
    return call(
      surah: provider.surah,
      reciter: provider.reciter,
      image: provider.image,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateSMTCProvider';
}

/// See also [updateSMTC].
class UpdateSMTCProvider extends AutoDisposeProvider<Object?> {
  /// See also [updateSMTC].
  UpdateSMTCProvider({
    required String surah,
    required String reciter,
    required String image,
  }) : this._internal(
          (ref) => updateSMTC(
            ref as UpdateSMTCRef,
            surah: surah,
            reciter: reciter,
            image: image,
          ),
          from: updateSMTCProvider,
          name: r'updateSMTCProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateSMTCHash,
          dependencies: UpdateSMTCFamily._dependencies,
          allTransitiveDependencies:
              UpdateSMTCFamily._allTransitiveDependencies,
          surah: surah,
          reciter: reciter,
          image: image,
        );

  UpdateSMTCProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.surah,
    required this.reciter,
    required this.image,
  }) : super.internal();

  final String surah;
  final String reciter;
  final String image;

  @override
  Override overrideWith(
    Object? Function(UpdateSMTCRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateSMTCProvider._internal(
        (ref) => create(ref as UpdateSMTCRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        surah: surah,
        reciter: reciter,
        image: image,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Object?> createElement() {
    return _UpdateSMTCProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateSMTCProvider &&
        other.surah == surah &&
        other.reciter == reciter &&
        other.image == image;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, surah.hashCode);
    hash = _SystemHash.combine(hash, reciter.hashCode);
    hash = _SystemHash.combine(hash, image.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UpdateSMTCRef on AutoDisposeProviderRef<Object?> {
  /// The parameter `surah` of this provider.
  String get surah;

  /// The parameter `reciter` of this provider.
  String get reciter;

  /// The parameter `image` of this provider.
  String get image;
}

class _UpdateSMTCProviderElement extends AutoDisposeProviderElement<Object?>
    with UpdateSMTCRef {
  _UpdateSMTCProviderElement(super.provider);

  @override
  String get surah => (origin as UpdateSMTCProvider).surah;
  @override
  String get reciter => (origin as UpdateSMTCProvider).reciter;
  @override
  String get image => (origin as UpdateSMTCProvider).image;
}

String _$initSMTCHash() => r'ac8885da11421ae6415f72bf6e830dfbefd508e8';

/// See also [initSMTC].
@ProviderFor(initSMTC)
const initSMTCProvider = InitSMTCFamily();

/// See also [initSMTC].
class InitSMTCFamily extends Family<Object?> {
  /// See also [initSMTC].
  const InitSMTCFamily();

  /// See also [initSMTC].
  InitSMTCProvider call({
    required String surah,
    required String reciter,
    required String image,
    required int position,
    required int duration,
  }) {
    return InitSMTCProvider(
      surah: surah,
      reciter: reciter,
      image: image,
      position: position,
      duration: duration,
    );
  }

  @override
  InitSMTCProvider getProviderOverride(
    covariant InitSMTCProvider provider,
  ) {
    return call(
      surah: provider.surah,
      reciter: provider.reciter,
      image: provider.image,
      position: provider.position,
      duration: provider.duration,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'initSMTCProvider';
}

/// See also [initSMTC].
class InitSMTCProvider extends AutoDisposeProvider<Object?> {
  /// See also [initSMTC].
  InitSMTCProvider({
    required String surah,
    required String reciter,
    required String image,
    required int position,
    required int duration,
  }) : this._internal(
          (ref) => initSMTC(
            ref as InitSMTCRef,
            surah: surah,
            reciter: reciter,
            image: image,
            position: position,
            duration: duration,
          ),
          from: initSMTCProvider,
          name: r'initSMTCProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$initSMTCHash,
          dependencies: InitSMTCFamily._dependencies,
          allTransitiveDependencies: InitSMTCFamily._allTransitiveDependencies,
          surah: surah,
          reciter: reciter,
          image: image,
          position: position,
          duration: duration,
        );

  InitSMTCProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.surah,
    required this.reciter,
    required this.image,
    required this.position,
    required this.duration,
  }) : super.internal();

  final String surah;
  final String reciter;
  final String image;
  final int position;
  final int duration;

  @override
  Override overrideWith(
    Object? Function(InitSMTCRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InitSMTCProvider._internal(
        (ref) => create(ref as InitSMTCRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        surah: surah,
        reciter: reciter,
        image: image,
        position: position,
        duration: duration,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Object?> createElement() {
    return _InitSMTCProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InitSMTCProvider &&
        other.surah == surah &&
        other.reciter == reciter &&
        other.image == image &&
        other.position == position &&
        other.duration == duration;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, surah.hashCode);
    hash = _SystemHash.combine(hash, reciter.hashCode);
    hash = _SystemHash.combine(hash, image.hashCode);
    hash = _SystemHash.combine(hash, position.hashCode);
    hash = _SystemHash.combine(hash, duration.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin InitSMTCRef on AutoDisposeProviderRef<Object?> {
  /// The parameter `surah` of this provider.
  String get surah;

  /// The parameter `reciter` of this provider.
  String get reciter;

  /// The parameter `image` of this provider.
  String get image;

  /// The parameter `position` of this provider.
  int get position;

  /// The parameter `duration` of this provider.
  int get duration;
}

class _InitSMTCProviderElement extends AutoDisposeProviderElement<Object?>
    with InitSMTCRef {
  _InitSMTCProviderElement(super.provider);

  @override
  String get surah => (origin as InitSMTCProvider).surah;
  @override
  String get reciter => (origin as InitSMTCProvider).reciter;
  @override
  String get image => (origin as InitSMTCProvider).image;
  @override
  int get position => (origin as InitSMTCProvider).position;
  @override
  int get duration => (origin as InitSMTCProvider).duration;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

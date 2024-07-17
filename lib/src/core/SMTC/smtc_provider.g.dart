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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

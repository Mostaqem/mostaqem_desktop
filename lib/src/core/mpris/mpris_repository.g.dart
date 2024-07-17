// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mpris_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createMetadataHash() => r'0b4ffa9807a8e0bd7f50db22101820fee3a62e40';

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

/// See also [createMetadata].
@ProviderFor(createMetadata)
const createMetadataProvider = CreateMetadataFamily();

/// See also [createMetadata].
class CreateMetadataFamily extends Family<AsyncValue<void>> {
  /// See also [createMetadata].
  const CreateMetadataFamily();

  /// See also [createMetadata].
  CreateMetadataProvider call({
    required String reciterName,
    required String surah,
    required String image,
    required String url,
    required Duration position,
  }) {
    return CreateMetadataProvider(
      reciterName: reciterName,
      surah: surah,
      image: image,
      url: url,
      position: position,
    );
  }

  @override
  CreateMetadataProvider getProviderOverride(
    covariant CreateMetadataProvider provider,
  ) {
    return call(
      reciterName: provider.reciterName,
      surah: provider.surah,
      image: provider.image,
      url: provider.url,
      position: provider.position,
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
  String? get name => r'createMetadataProvider';
}

/// See also [createMetadata].
class CreateMetadataProvider extends AutoDisposeFutureProvider<void> {
  /// See also [createMetadata].
  CreateMetadataProvider({
    required String reciterName,
    required String surah,
    required String image,
    required String url,
    required Duration position,
  }) : this._internal(
          (ref) => createMetadata(
            ref as CreateMetadataRef,
            reciterName: reciterName,
            surah: surah,
            image: image,
            url: url,
            position: position,
          ),
          from: createMetadataProvider,
          name: r'createMetadataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createMetadataHash,
          dependencies: CreateMetadataFamily._dependencies,
          allTransitiveDependencies:
              CreateMetadataFamily._allTransitiveDependencies,
          reciterName: reciterName,
          surah: surah,
          image: image,
          url: url,
          position: position,
        );

  CreateMetadataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.reciterName,
    required this.surah,
    required this.image,
    required this.url,
    required this.position,
  }) : super.internal();

  final String reciterName;
  final String surah;
  final String image;
  final String url;
  final Duration position;

  @override
  Override overrideWith(
    FutureOr<void> Function(CreateMetadataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateMetadataProvider._internal(
        (ref) => create(ref as CreateMetadataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        reciterName: reciterName,
        surah: surah,
        image: image,
        url: url,
        position: position,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _CreateMetadataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateMetadataProvider &&
        other.reciterName == reciterName &&
        other.surah == surah &&
        other.image == image &&
        other.url == url &&
        other.position == position;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, reciterName.hashCode);
    hash = _SystemHash.combine(hash, surah.hashCode);
    hash = _SystemHash.combine(hash, image.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);
    hash = _SystemHash.combine(hash, position.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CreateMetadataRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `reciterName` of this provider.
  String get reciterName;

  /// The parameter `surah` of this provider.
  String get surah;

  /// The parameter `image` of this provider.
  String get image;

  /// The parameter `url` of this provider.
  String get url;

  /// The parameter `position` of this provider.
  Duration get position;
}

class _CreateMetadataProviderElement
    extends AutoDisposeFutureProviderElement<void> with CreateMetadataRef {
  _CreateMetadataProviderElement(super.provider);

  @override
  String get reciterName => (origin as CreateMetadataProvider).reciterName;
  @override
  String get surah => (origin as CreateMetadataProvider).surah;
  @override
  String get image => (origin as CreateMetadataProvider).image;
  @override
  String get url => (origin as CreateMetadataProvider).url;
  @override
  Duration get position => (origin as CreateMetadataProvider).position;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

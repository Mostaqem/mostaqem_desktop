// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_cache.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playerCacheHash() => r'930909dbdd4bf1d7ff50709aa0aeeaf3b13242be';

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

abstract class _$PlayerCache extends BuildlessAutoDisposeNotifier<Album?> {
  late final String key;

  Album? build({
    String key = 'surah',
  });
}

/// See also [PlayerCache].
@ProviderFor(PlayerCache)
const playerCacheProvider = PlayerCacheFamily();

/// See also [PlayerCache].
class PlayerCacheFamily extends Family<Album?> {
  /// See also [PlayerCache].
  const PlayerCacheFamily();

  /// See also [PlayerCache].
  PlayerCacheProvider call({
    String key = 'surah',
  }) {
    return PlayerCacheProvider(
      key: key,
    );
  }

  @override
  PlayerCacheProvider getProviderOverride(
    covariant PlayerCacheProvider provider,
  ) {
    return call(
      key: provider.key,
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
  String? get name => r'playerCacheProvider';
}

/// See also [PlayerCache].
class PlayerCacheProvider
    extends AutoDisposeNotifierProviderImpl<PlayerCache, Album?> {
  /// See also [PlayerCache].
  PlayerCacheProvider({
    String key = 'surah',
  }) : this._internal(
          () => PlayerCache()..key = key,
          from: playerCacheProvider,
          name: r'playerCacheProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$playerCacheHash,
          dependencies: PlayerCacheFamily._dependencies,
          allTransitiveDependencies:
              PlayerCacheFamily._allTransitiveDependencies,
          key: key,
        );

  PlayerCacheProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.key,
  }) : super.internal();

  final String key;

  @override
  Album? runNotifierBuild(
    covariant PlayerCache notifier,
  ) {
    return notifier.build(
      key: key,
    );
  }

  @override
  Override overrideWith(PlayerCache Function() create) {
    return ProviderOverride(
      origin: this,
      override: PlayerCacheProvider._internal(
        () => create()..key = key,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        key: key,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<PlayerCache, Album?> createElement() {
    return _PlayerCacheProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlayerCacheProvider && other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PlayerCacheRef on AutoDisposeNotifierProviderRef<Album?> {
  /// The parameter `key` of this provider.
  String get key;
}

class _PlayerCacheProviderElement
    extends AutoDisposeNotifierProviderElement<PlayerCache, Album?>
    with PlayerCacheRef {
  _PlayerCacheProviderElement(super.provider);

  @override
  String get key => (origin as PlayerCacheProvider).key;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

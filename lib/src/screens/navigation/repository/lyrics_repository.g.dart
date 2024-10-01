// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyrics_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getLyricsHash() => r'24c934303d8664c7ad53a602c5a3f5657fd05cb3';

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

/// See also [getLyrics].
@ProviderFor(getLyrics)
const getLyricsProvider = GetLyricsFamily();

/// See also [getLyrics].
class GetLyricsFamily extends Family<AsyncValue<String?>> {
  /// See also [getLyrics].
  const GetLyricsFamily();

  /// See also [getLyrics].
  GetLyricsProvider call({
    required String filename,
  }) {
    return GetLyricsProvider(
      filename: filename,
    );
  }

  @override
  GetLyricsProvider getProviderOverride(
    covariant GetLyricsProvider provider,
  ) {
    return call(
      filename: provider.filename,
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
  String? get name => r'getLyricsProvider';
}

/// See also [getLyrics].
class GetLyricsProvider extends AutoDisposeFutureProvider<String?> {
  /// See also [getLyrics].
  GetLyricsProvider({
    required String filename,
  }) : this._internal(
          (ref) => getLyrics(
            ref as GetLyricsRef,
            filename: filename,
          ),
          from: getLyricsProvider,
          name: r'getLyricsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getLyricsHash,
          dependencies: GetLyricsFamily._dependencies,
          allTransitiveDependencies: GetLyricsFamily._allTransitiveDependencies,
          filename: filename,
        );

  GetLyricsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filename,
  }) : super.internal();

  final String filename;

  @override
  Override overrideWith(
    FutureOr<String?> Function(GetLyricsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetLyricsProvider._internal(
        (ref) => create(ref as GetLyricsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filename: filename,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String?> createElement() {
    return _GetLyricsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetLyricsProvider && other.filename == filename;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filename.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetLyricsRef on AutoDisposeFutureProviderRef<String?> {
  /// The parameter `filename` of this provider.
  String get filename;
}

class _GetLyricsProviderElement
    extends AutoDisposeFutureProviderElement<String?> with GetLyricsRef {
  _GetLyricsProviderElement(super.provider);

  @override
  String get filename => (origin as GetLyricsProvider).filename;
}

String _$cacheLyricsHash() => r'07fd5c24cf26061720823ea2701ae224a4b83931';

/// See also [cacheLyrics].
@ProviderFor(cacheLyrics)
const cacheLyricsProvider = CacheLyricsFamily();

/// See also [cacheLyrics].
class CacheLyricsFamily extends Family<AsyncValue<File>> {
  /// See also [cacheLyrics].
  const CacheLyricsFamily();

  /// See also [cacheLyrics].
  CacheLyricsProvider call({
    required String filename,
    required String content,
  }) {
    return CacheLyricsProvider(
      filename: filename,
      content: content,
    );
  }

  @override
  CacheLyricsProvider getProviderOverride(
    covariant CacheLyricsProvider provider,
  ) {
    return call(
      filename: provider.filename,
      content: provider.content,
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
  String? get name => r'cacheLyricsProvider';
}

/// See also [cacheLyrics].
class CacheLyricsProvider extends AutoDisposeFutureProvider<File> {
  /// See also [cacheLyrics].
  CacheLyricsProvider({
    required String filename,
    required String content,
  }) : this._internal(
          (ref) => cacheLyrics(
            ref as CacheLyricsRef,
            filename: filename,
            content: content,
          ),
          from: cacheLyricsProvider,
          name: r'cacheLyricsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cacheLyricsHash,
          dependencies: CacheLyricsFamily._dependencies,
          allTransitiveDependencies:
              CacheLyricsFamily._allTransitiveDependencies,
          filename: filename,
          content: content,
        );

  CacheLyricsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filename,
    required this.content,
  }) : super.internal();

  final String filename;
  final String content;

  @override
  Override overrideWith(
    FutureOr<File> Function(CacheLyricsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CacheLyricsProvider._internal(
        (ref) => create(ref as CacheLyricsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filename: filename,
        content: content,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<File> createElement() {
    return _CacheLyricsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CacheLyricsProvider &&
        other.filename == filename &&
        other.content == content;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filename.hashCode);
    hash = _SystemHash.combine(hash, content.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CacheLyricsRef on AutoDisposeFutureProviderRef<File> {
  /// The parameter `filename` of this provider.
  String get filename;

  /// The parameter `content` of this provider.
  String get content;
}

class _CacheLyricsProviderElement extends AutoDisposeFutureProviderElement<File>
    with CacheLyricsRef {
  _CacheLyricsProviderElement(super.provider);

  @override
  String get filename => (origin as CacheLyricsProvider).filename;
  @override
  String get content => (origin as CacheLyricsProvider).content;
}

String _$syncLyricsHash() => r'16538a89244ef1afefcd41a591a9f054285cf12a';

/// See also [syncLyrics].
@ProviderFor(syncLyrics)
final syncLyricsProvider = AutoDisposeFutureProvider<
    ({int currentIndex, List<Lyrics> lyricsList})?>.internal(
  syncLyrics,
  name: r'syncLyricsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$syncLyricsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SyncLyricsRef = AutoDisposeFutureProviderRef<
    ({int currentIndex, List<Lyrics> lyricsList})?>;
String _$currentLyricsNotifierHash() =>
    r'65cd2261ad541f6a7b43d000872dd1c0f41ee89a';

/// See also [CurrentLyricsNotifier].
@ProviderFor(CurrentLyricsNotifier)
final currentLyricsNotifierProvider = AutoDisposeAsyncNotifierProvider<
    CurrentLyricsNotifier,
    ({int currentIndex, List<Lyrics> lyricsList})?>.internal(
  CurrentLyricsNotifier.new,
  name: r'currentLyricsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentLyricsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentLyricsNotifier
    = AutoDisposeAsyncNotifier<({int currentIndex, List<Lyrics> lyricsList})?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

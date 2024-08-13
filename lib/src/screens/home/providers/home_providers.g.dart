// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchAllChaptersHash() => r'3e8fc0ebee69385d9e43b9187ea82cf55040941f';

/// Fetches all the chapters
///
/// Copied from [fetchAllChapters].
@ProviderFor(fetchAllChapters)
final fetchAllChaptersProvider = FutureProvider<List<Surah>>.internal(
  fetchAllChapters,
  name: r'fetchAllChaptersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchAllChaptersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchAllChaptersRef = FutureProviderRef<List<Surah>>;
String _$fetchChapterByIdHash() => r'26a2fde193ae47d75901e800dee5f8afecd81cdf';

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

/// Fetches chapter by [id]
///
/// Copied from [fetchChapterById].
@ProviderFor(fetchChapterById)
const fetchChapterByIdProvider = FetchChapterByIdFamily();

/// Fetches chapter by [id]
///
/// Copied from [fetchChapterById].
class FetchChapterByIdFamily extends Family<AsyncValue<Surah>> {
  /// Fetches chapter by [id]
  ///
  /// Copied from [fetchChapterById].
  const FetchChapterByIdFamily();

  /// Fetches chapter by [id]
  ///
  /// Copied from [fetchChapterById].
  FetchChapterByIdProvider call({
    required int id,
  }) {
    return FetchChapterByIdProvider(
      id: id,
    );
  }

  @override
  FetchChapterByIdProvider getProviderOverride(
    covariant FetchChapterByIdProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'fetchChapterByIdProvider';
}

/// Fetches chapter by [id]
///
/// Copied from [fetchChapterById].
class FetchChapterByIdProvider extends AutoDisposeFutureProvider<Surah> {
  /// Fetches chapter by [id]
  ///
  /// Copied from [fetchChapterById].
  FetchChapterByIdProvider({
    required int id,
  }) : this._internal(
          (ref) => fetchChapterById(
            ref as FetchChapterByIdRef,
            id: id,
          ),
          from: fetchChapterByIdProvider,
          name: r'fetchChapterByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchChapterByIdHash,
          dependencies: FetchChapterByIdFamily._dependencies,
          allTransitiveDependencies:
              FetchChapterByIdFamily._allTransitiveDependencies,
          id: id,
        );

  FetchChapterByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<Surah> Function(FetchChapterByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchChapterByIdProvider._internal(
        (ref) => create(ref as FetchChapterByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Surah> createElement() {
    return _FetchChapterByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchChapterByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchChapterByIdRef on AutoDisposeFutureProviderRef<Surah> {
  /// The parameter `id` of this provider.
  int get id;
}

class _FetchChapterByIdProviderElement
    extends AutoDisposeFutureProviderElement<Surah> with FetchChapterByIdRef {
  _FetchChapterByIdProviderElement(super.provider);

  @override
  int get id => (origin as FetchChapterByIdProvider).id;
}

String _$fetchAudioForChapterHash() =>
    r'd7e03c25adf8e39f42009be6f5e7a12787c48b36';

/// Fetches audio for chapter by [chapterNumber] and [reciterID]
///
/// Copied from [fetchAudioForChapter].
@ProviderFor(fetchAudioForChapter)
const fetchAudioForChapterProvider = FetchAudioForChapterFamily();

/// Fetches audio for chapter by [chapterNumber] and [reciterID]
///
/// Copied from [fetchAudioForChapter].
class FetchAudioForChapterFamily
    extends Family<AsyncValue<Tuple2<String, int>>> {
  /// Fetches audio for chapter by [chapterNumber] and [reciterID]
  ///
  /// Copied from [fetchAudioForChapter].
  const FetchAudioForChapterFamily();

  /// Fetches audio for chapter by [chapterNumber] and [reciterID]
  ///
  /// Copied from [fetchAudioForChapter].
  FetchAudioForChapterProvider call({
    required int chapterNumber,
    int? recitationID,
    int reciterID = 1,
  }) {
    return FetchAudioForChapterProvider(
      chapterNumber: chapterNumber,
      recitationID: recitationID,
      reciterID: reciterID,
    );
  }

  @override
  FetchAudioForChapterProvider getProviderOverride(
    covariant FetchAudioForChapterProvider provider,
  ) {
    return call(
      chapterNumber: provider.chapterNumber,
      recitationID: provider.recitationID,
      reciterID: provider.reciterID,
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
  String? get name => r'fetchAudioForChapterProvider';
}

/// Fetches audio for chapter by [chapterNumber] and [reciterID]
///
/// Copied from [fetchAudioForChapter].
class FetchAudioForChapterProvider
    extends AutoDisposeFutureProvider<Tuple2<String, int>> {
  /// Fetches audio for chapter by [chapterNumber] and [reciterID]
  ///
  /// Copied from [fetchAudioForChapter].
  FetchAudioForChapterProvider({
    required int chapterNumber,
    int? recitationID,
    int reciterID = 1,
  }) : this._internal(
          (ref) => fetchAudioForChapter(
            ref as FetchAudioForChapterRef,
            chapterNumber: chapterNumber,
            recitationID: recitationID,
            reciterID: reciterID,
          ),
          from: fetchAudioForChapterProvider,
          name: r'fetchAudioForChapterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchAudioForChapterHash,
          dependencies: FetchAudioForChapterFamily._dependencies,
          allTransitiveDependencies:
              FetchAudioForChapterFamily._allTransitiveDependencies,
          chapterNumber: chapterNumber,
          recitationID: recitationID,
          reciterID: reciterID,
        );

  FetchAudioForChapterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chapterNumber,
    required this.recitationID,
    required this.reciterID,
  }) : super.internal();

  final int chapterNumber;
  final int? recitationID;
  final int reciterID;

  @override
  Override overrideWith(
    FutureOr<Tuple2<String, int>> Function(FetchAudioForChapterRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchAudioForChapterProvider._internal(
        (ref) => create(ref as FetchAudioForChapterRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chapterNumber: chapterNumber,
        recitationID: recitationID,
        reciterID: reciterID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Tuple2<String, int>> createElement() {
    return _FetchAudioForChapterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchAudioForChapterProvider &&
        other.chapterNumber == chapterNumber &&
        other.recitationID == recitationID &&
        other.reciterID == reciterID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chapterNumber.hashCode);
    hash = _SystemHash.combine(hash, recitationID.hashCode);
    hash = _SystemHash.combine(hash, reciterID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchAudioForChapterRef
    on AutoDisposeFutureProviderRef<Tuple2<String, int>> {
  /// The parameter `chapterNumber` of this provider.
  int get chapterNumber;

  /// The parameter `recitationID` of this provider.
  int? get recitationID;

  /// The parameter `reciterID` of this provider.
  int get reciterID;
}

class _FetchAudioForChapterProviderElement
    extends AutoDisposeFutureProviderElement<Tuple2<String, int>>
    with FetchAudioForChapterRef {
  _FetchAudioForChapterProviderElement(super.provider);

  @override
  int get chapterNumber =>
      (origin as FetchAudioForChapterProvider).chapterNumber;
  @override
  int? get recitationID =>
      (origin as FetchAudioForChapterProvider).recitationID;
  @override
  int get reciterID => (origin as FetchAudioForChapterProvider).reciterID;
}

String _$filterSurahByQueryHash() =>
    r'97ae546588e96be7e12abb98b2bf6b421e1d4921';

/// Filters chapters by search query
///
/// Copied from [filterSurahByQuery].
@ProviderFor(filterSurahByQuery)
final filterSurahByQueryProvider =
    AutoDisposeFutureProvider<List<Surah>>.internal(
  filterSurahByQuery,
  name: r'filterSurahByQueryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filterSurahByQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FilterSurahByQueryRef = AutoDisposeFutureProviderRef<List<Surah>>;
String _$fetchNextSurahHash() => r'340dbef4556d3b2018dabffcfea17f29bce5be91';

/// Fetches the next chapter
///
/// Copied from [fetchNextSurah].
@ProviderFor(fetchNextSurah)
final fetchNextSurahProvider = AutoDisposeFutureProvider<Surah?>.internal(
  fetchNextSurah,
  name: r'fetchNextSurahProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchNextSurahHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchNextSurahRef = AutoDisposeFutureProviderRef<Surah?>;
String _$fetchRandomImageHash() => r'654b50af4c87b5f5a1146f7a0e973c0f98ae580e';

/// Fetches random image from Unsplash API
///
/// Copied from [fetchRandomImage].
@ProviderFor(fetchRandomImage)
final fetchRandomImageProvider = AutoDisposeFutureProvider<String>.internal(
  fetchRandomImage,
  name: r'fetchRandomImageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchRandomImageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchRandomImageRef = AutoDisposeFutureProviderRef<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

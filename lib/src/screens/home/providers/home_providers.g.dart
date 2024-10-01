// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchAllChaptersHash() => r'025d414a949c067e57d6453da31800783aaaf4d2';

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

/// Fetches all the chapters
///
/// Copied from [fetchAllChapters].
@ProviderFor(fetchAllChapters)
const fetchAllChaptersProvider = FetchAllChaptersFamily();

/// Fetches all the chapters
///
/// Copied from [fetchAllChapters].
class FetchAllChaptersFamily extends Family<AsyncValue<List<Surah>>> {
  /// Fetches all the chapters
  ///
  /// Copied from [fetchAllChapters].
  const FetchAllChaptersFamily();

  /// Fetches all the chapters
  ///
  /// Copied from [fetchAllChapters].
  FetchAllChaptersProvider call({
    required int page,
    String? query,
  }) {
    return FetchAllChaptersProvider(
      page: page,
      query: query,
    );
  }

  @override
  FetchAllChaptersProvider getProviderOverride(
    covariant FetchAllChaptersProvider provider,
  ) {
    return call(
      page: provider.page,
      query: provider.query,
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
  String? get name => r'fetchAllChaptersProvider';
}

/// Fetches all the chapters
///
/// Copied from [fetchAllChapters].
class FetchAllChaptersProvider extends FutureProvider<List<Surah>> {
  /// Fetches all the chapters
  ///
  /// Copied from [fetchAllChapters].
  FetchAllChaptersProvider({
    required int page,
    String? query,
  }) : this._internal(
          (ref) => fetchAllChapters(
            ref as FetchAllChaptersRef,
            page: page,
            query: query,
          ),
          from: fetchAllChaptersProvider,
          name: r'fetchAllChaptersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchAllChaptersHash,
          dependencies: FetchAllChaptersFamily._dependencies,
          allTransitiveDependencies:
              FetchAllChaptersFamily._allTransitiveDependencies,
          page: page,
          query: query,
        );

  FetchAllChaptersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
    required this.query,
  }) : super.internal();

  final int page;
  final String? query;

  @override
  Override overrideWith(
    FutureOr<List<Surah>> Function(FetchAllChaptersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchAllChaptersProvider._internal(
        (ref) => create(ref as FetchAllChaptersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
        query: query,
      ),
    );
  }

  @override
  FutureProviderElement<List<Surah>> createElement() {
    return _FetchAllChaptersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchAllChaptersProvider &&
        other.page == page &&
        other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchAllChaptersRef on FutureProviderRef<List<Surah>> {
  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `query` of this provider.
  String? get query;
}

class _FetchAllChaptersProviderElement
    extends FutureProviderElement<List<Surah>> with FetchAllChaptersRef {
  _FetchAllChaptersProviderElement(super.provider);

  @override
  int get page => (origin as FetchAllChaptersProvider).page;
  @override
  String? get query => (origin as FetchAllChaptersProvider).query;
}

String _$fetchChapterByIdHash() => r'26a2fde193ae47d75901e800dee5f8afecd81cdf';

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
    r'043aae0850fb3ebf449edc654fd892fc84e7f4a3';

/// Fetches audio for chapter by [chapterNumber] and [reciterID]
///
/// Copied from [fetchAudioForChapter].
@ProviderFor(fetchAudioForChapter)
const fetchAudioForChapterProvider = FetchAudioForChapterFamily();

/// Fetches audio for chapter by [chapterNumber] and [reciterID]
///
/// Copied from [fetchAudioForChapter].
class FetchAudioForChapterFamily
    extends Family<AsyncValue<({String url, int recitationID})>> {
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
    int? reciterID,
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
    extends AutoDisposeFutureProvider<({String url, int recitationID})> {
  /// Fetches audio for chapter by [chapterNumber] and [reciterID]
  ///
  /// Copied from [fetchAudioForChapter].
  FetchAudioForChapterProvider({
    required int chapterNumber,
    int? recitationID,
    int? reciterID,
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
  final int? reciterID;

  @override
  Override overrideWith(
    FutureOr<({String url, int recitationID})> Function(
            FetchAudioForChapterRef provider)
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
  AutoDisposeFutureProviderElement<({String url, int recitationID})>
      createElement() {
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
    on AutoDisposeFutureProviderRef<({String url, int recitationID})> {
  /// The parameter `chapterNumber` of this provider.
  int get chapterNumber;

  /// The parameter `recitationID` of this provider.
  int? get recitationID;

  /// The parameter `reciterID` of this provider.
  int? get reciterID;
}

class _FetchAudioForChapterProviderElement
    extends AutoDisposeFutureProviderElement<({String url, int recitationID})>
    with FetchAudioForChapterRef {
  _FetchAudioForChapterProviderElement(super.provider);

  @override
  int get chapterNumber =>
      (origin as FetchAudioForChapterProvider).chapterNumber;
  @override
  int? get recitationID =>
      (origin as FetchAudioForChapterProvider).recitationID;
  @override
  int? get reciterID => (origin as FetchAudioForChapterProvider).reciterID;
}

String _$fetchNextSurahHash() => r'59339eaf6c67f671d0e061075b9a2db19d9bace5';

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
String _$fetchSurahLyricsHash() => r'332382283caa38d0336fdaeab4cc22d71fc66920';

/// See also [fetchSurahLyrics].
@ProviderFor(fetchSurahLyrics)
const fetchSurahLyricsProvider = FetchSurahLyricsFamily();

/// See also [fetchSurahLyrics].
class FetchSurahLyricsFamily extends Family<AsyncValue<String?>> {
  /// See also [fetchSurahLyrics].
  const FetchSurahLyricsFamily();

  /// See also [fetchSurahLyrics].
  FetchSurahLyricsProvider call({
    required int surahID,
    required int recitationID,
  }) {
    return FetchSurahLyricsProvider(
      surahID: surahID,
      recitationID: recitationID,
    );
  }

  @override
  FetchSurahLyricsProvider getProviderOverride(
    covariant FetchSurahLyricsProvider provider,
  ) {
    return call(
      surahID: provider.surahID,
      recitationID: provider.recitationID,
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
  String? get name => r'fetchSurahLyricsProvider';
}

/// See also [fetchSurahLyrics].
class FetchSurahLyricsProvider extends AutoDisposeFutureProvider<String?> {
  /// See also [fetchSurahLyrics].
  FetchSurahLyricsProvider({
    required int surahID,
    required int recitationID,
  }) : this._internal(
          (ref) => fetchSurahLyrics(
            ref as FetchSurahLyricsRef,
            surahID: surahID,
            recitationID: recitationID,
          ),
          from: fetchSurahLyricsProvider,
          name: r'fetchSurahLyricsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchSurahLyricsHash,
          dependencies: FetchSurahLyricsFamily._dependencies,
          allTransitiveDependencies:
              FetchSurahLyricsFamily._allTransitiveDependencies,
          surahID: surahID,
          recitationID: recitationID,
        );

  FetchSurahLyricsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.surahID,
    required this.recitationID,
  }) : super.internal();

  final int surahID;
  final int recitationID;

  @override
  Override overrideWith(
    FutureOr<String?> Function(FetchSurahLyricsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchSurahLyricsProvider._internal(
        (ref) => create(ref as FetchSurahLyricsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        surahID: surahID,
        recitationID: recitationID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String?> createElement() {
    return _FetchSurahLyricsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchSurahLyricsProvider &&
        other.surahID == surahID &&
        other.recitationID == recitationID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, surahID.hashCode);
    hash = _SystemHash.combine(hash, recitationID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchSurahLyricsRef on AutoDisposeFutureProviderRef<String?> {
  /// The parameter `surahID` of this provider.
  int get surahID;

  /// The parameter `recitationID` of this provider.
  int get recitationID;
}

class _FetchSurahLyricsProviderElement
    extends AutoDisposeFutureProviderElement<String?> with FetchSurahLyricsRef {
  _FetchSurahLyricsProviderElement(super.provider);

  @override
  int get surahID => (origin as FetchSurahLyricsProvider).surahID;
  @override
  int get recitationID => (origin as FetchSurahLyricsProvider).recitationID;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

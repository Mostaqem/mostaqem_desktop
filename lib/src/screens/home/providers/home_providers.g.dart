// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchAllChaptersHash() => r'8fac0d8997a0335a0aad39583dac17af26f94226';

/// See also [fetchAllChapters].
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
String _$fetchChapterByIdHash() => r'46efa6a009c0cd9b7bacbc0f8c043377fc517ca9';

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

/// See also [fetchChapterById].
@ProviderFor(fetchChapterById)
const fetchChapterByIdProvider = FetchChapterByIdFamily();

/// See also [fetchChapterById].
class FetchChapterByIdFamily extends Family<AsyncValue<Surah>> {
  /// See also [fetchChapterById].
  const FetchChapterByIdFamily();

  /// See also [fetchChapterById].
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

/// See also [fetchChapterById].
class FetchChapterByIdProvider extends AutoDisposeFutureProvider<Surah> {
  /// See also [fetchChapterById].
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
    r'db191f31aecc077aa2ca8b92046d858210ba97da';

/// See also [fetchAudioForChapter].
@ProviderFor(fetchAudioForChapter)
const fetchAudioForChapterProvider = FetchAudioForChapterFamily();

/// See also [fetchAudioForChapter].
class FetchAudioForChapterFamily extends Family<AsyncValue<String>> {
  /// See also [fetchAudioForChapter].
  const FetchAudioForChapterFamily();

  /// See also [fetchAudioForChapter].
  FetchAudioForChapterProvider call({
    int reciterID = 1,
    required int chapterNumber,
  }) {
    return FetchAudioForChapterProvider(
      reciterID: reciterID,
      chapterNumber: chapterNumber,
    );
  }

  @override
  FetchAudioForChapterProvider getProviderOverride(
    covariant FetchAudioForChapterProvider provider,
  ) {
    return call(
      reciterID: provider.reciterID,
      chapterNumber: provider.chapterNumber,
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

/// See also [fetchAudioForChapter].
class FetchAudioForChapterProvider extends AutoDisposeFutureProvider<String> {
  /// See also [fetchAudioForChapter].
  FetchAudioForChapterProvider({
    int reciterID = 1,
    required int chapterNumber,
  }) : this._internal(
          (ref) => fetchAudioForChapter(
            ref as FetchAudioForChapterRef,
            reciterID: reciterID,
            chapterNumber: chapterNumber,
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
          reciterID: reciterID,
          chapterNumber: chapterNumber,
        );

  FetchAudioForChapterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.reciterID,
    required this.chapterNumber,
  }) : super.internal();

  final int reciterID;
  final int chapterNumber;

  @override
  Override overrideWith(
    FutureOr<String> Function(FetchAudioForChapterRef provider) create,
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
        reciterID: reciterID,
        chapterNumber: chapterNumber,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _FetchAudioForChapterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchAudioForChapterProvider &&
        other.reciterID == reciterID &&
        other.chapterNumber == chapterNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, reciterID.hashCode);
    hash = _SystemHash.combine(hash, chapterNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchAudioForChapterRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `reciterID` of this provider.
  int get reciterID;

  /// The parameter `chapterNumber` of this provider.
  int get chapterNumber;
}

class _FetchAudioForChapterProviderElement
    extends AutoDisposeFutureProviderElement<String>
    with FetchAudioForChapterRef {
  _FetchAudioForChapterProviderElement(super.provider);

  @override
  int get reciterID => (origin as FetchAudioForChapterProvider).reciterID;
  @override
  int get chapterNumber =>
      (origin as FetchAudioForChapterProvider).chapterNumber;
}

String _$seekIDHash() => r'c5c0880d9b4b11125e520496b19add2616f07044';

/// See also [seekID].
@ProviderFor(seekID)
const seekIDProvider = SeekIDFamily();

/// See also [seekID].
class SeekIDFamily extends Family<AsyncValue<void>> {
  /// See also [seekID].
  const SeekIDFamily();

  /// See also [seekID].
  SeekIDProvider call({
    required int surahID,
    String? surahName,
    String? image,
    String? surahSimpleName,
    required ({int id, String name}) reciter,
  }) {
    return SeekIDProvider(
      surahID: surahID,
      surahName: surahName,
      image: image,
      surahSimpleName: surahSimpleName,
      reciter: reciter,
    );
  }

  @override
  SeekIDProvider getProviderOverride(
    covariant SeekIDProvider provider,
  ) {
    return call(
      surahID: provider.surahID,
      surahName: provider.surahName,
      image: provider.image,
      surahSimpleName: provider.surahSimpleName,
      reciter: provider.reciter,
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
  String? get name => r'seekIDProvider';
}

/// See also [seekID].
class SeekIDProvider extends AutoDisposeFutureProvider<void> {
  /// See also [seekID].
  SeekIDProvider({
    required int surahID,
    String? surahName,
    String? image,
    String? surahSimpleName,
    required ({int id, String name}) reciter,
  }) : this._internal(
          (ref) => seekID(
            ref as SeekIDRef,
            surahID: surahID,
            surahName: surahName,
            image: image,
            surahSimpleName: surahSimpleName,
            reciter: reciter,
          ),
          from: seekIDProvider,
          name: r'seekIDProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$seekIDHash,
          dependencies: SeekIDFamily._dependencies,
          allTransitiveDependencies: SeekIDFamily._allTransitiveDependencies,
          surahID: surahID,
          surahName: surahName,
          image: image,
          surahSimpleName: surahSimpleName,
          reciter: reciter,
        );

  SeekIDProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.surahID,
    required this.surahName,
    required this.image,
    required this.surahSimpleName,
    required this.reciter,
  }) : super.internal();

  final int surahID;
  final String? surahName;
  final String? image;
  final String? surahSimpleName;
  final ({int id, String name}) reciter;

  @override
  Override overrideWith(
    FutureOr<void> Function(SeekIDRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SeekIDProvider._internal(
        (ref) => create(ref as SeekIDRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        surahID: surahID,
        surahName: surahName,
        image: image,
        surahSimpleName: surahSimpleName,
        reciter: reciter,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _SeekIDProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SeekIDProvider &&
        other.surahID == surahID &&
        other.surahName == surahName &&
        other.image == image &&
        other.surahSimpleName == surahSimpleName &&
        other.reciter == reciter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, surahID.hashCode);
    hash = _SystemHash.combine(hash, surahName.hashCode);
    hash = _SystemHash.combine(hash, image.hashCode);
    hash = _SystemHash.combine(hash, surahSimpleName.hashCode);
    hash = _SystemHash.combine(hash, reciter.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SeekIDRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `surahID` of this provider.
  int get surahID;

  /// The parameter `surahName` of this provider.
  String? get surahName;

  /// The parameter `image` of this provider.
  String? get image;

  /// The parameter `surahSimpleName` of this provider.
  String? get surahSimpleName;

  /// The parameter `reciter` of this provider.
  ({int id, String name}) get reciter;
}

class _SeekIDProviderElement extends AutoDisposeFutureProviderElement<void>
    with SeekIDRef {
  _SeekIDProviderElement(super.provider);

  @override
  int get surahID => (origin as SeekIDProvider).surahID;
  @override
  String? get surahName => (origin as SeekIDProvider).surahName;
  @override
  String? get image => (origin as SeekIDProvider).image;
  @override
  String? get surahSimpleName => (origin as SeekIDProvider).surahSimpleName;
  @override
  ({int id, String name}) get reciter => (origin as SeekIDProvider).reciter;
}

String _$filterSurahByQueryHash() =>
    r'97ae546588e96be7e12abb98b2bf6b421e1d4921';

/// See also [filterSurahByQuery].
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
String _$fetchNextSurahHash() => r'50b0027df4965c90ba828bd498fd811aa44f886f';

/// See also [fetchNextSurah].
@ProviderFor(fetchNextSurah)
final fetchNextSurahProvider = FutureProvider<Surah>.internal(
  fetchNextSurah,
  name: r'fetchNextSurahProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchNextSurahHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchNextSurahRef = FutureProviderRef<Surah>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

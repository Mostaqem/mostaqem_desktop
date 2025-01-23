// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reciters_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchReciterHash() => r'ffff23bef35649571c52d2925adb01178a8c8c6f';

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

/// See also [fetchReciter].
@ProviderFor(fetchReciter)
const fetchReciterProvider = FetchReciterFamily();

/// See also [fetchReciter].
class FetchReciterFamily extends Family<AsyncValue<Reciter>> {
  /// See also [fetchReciter].
  const FetchReciterFamily();

  /// See also [fetchReciter].
  FetchReciterProvider call({
    required int id,
  }) {
    return FetchReciterProvider(
      id: id,
    );
  }

  @override
  FetchReciterProvider getProviderOverride(
    covariant FetchReciterProvider provider,
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
  String? get name => r'fetchReciterProvider';
}

/// See also [fetchReciter].
class FetchReciterProvider extends AutoDisposeFutureProvider<Reciter> {
  /// See also [fetchReciter].
  FetchReciterProvider({
    required int id,
  }) : this._internal(
          (ref) => fetchReciter(
            ref as FetchReciterRef,
            id: id,
          ),
          from: fetchReciterProvider,
          name: r'fetchReciterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchReciterHash,
          dependencies: FetchReciterFamily._dependencies,
          allTransitiveDependencies:
              FetchReciterFamily._allTransitiveDependencies,
          id: id,
        );

  FetchReciterProvider._internal(
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
    FutureOr<Reciter> Function(FetchReciterRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchReciterProvider._internal(
        (ref) => create(ref as FetchReciterRef),
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
  AutoDisposeFutureProviderElement<Reciter> createElement() {
    return _FetchReciterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchReciterProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchReciterRef on AutoDisposeFutureProviderRef<Reciter> {
  /// The parameter `id` of this provider.
  int get id;
}

class _FetchReciterProviderElement
    extends AutoDisposeFutureProviderElement<Reciter> with FetchReciterRef {
  _FetchReciterProviderElement(super.provider);

  @override
  int get id => (origin as FetchReciterProvider).id;
}

String _$fetchRecitersHash() => r'72823d617b912d0cbf5c9fbbfa9f68cbf9843ce4';

/// See also [fetchReciters].
@ProviderFor(fetchReciters)
const fetchRecitersProvider = FetchRecitersFamily();

/// See also [fetchReciters].
class FetchRecitersFamily extends Family<AsyncValue<List<Reciter>>> {
  /// See also [fetchReciters].
  const FetchRecitersFamily();

  /// See also [fetchReciters].
  FetchRecitersProvider call({
    required int page,
  }) {
    return FetchRecitersProvider(
      page: page,
    );
  }

  @override
  FetchRecitersProvider getProviderOverride(
    covariant FetchRecitersProvider provider,
  ) {
    return call(
      page: provider.page,
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
  String? get name => r'fetchRecitersProvider';
}

/// See also [fetchReciters].
class FetchRecitersProvider extends AutoDisposeFutureProvider<List<Reciter>> {
  /// See also [fetchReciters].
  FetchRecitersProvider({
    required int page,
  }) : this._internal(
          (ref) => fetchReciters(
            ref as FetchRecitersRef,
            page: page,
          ),
          from: fetchRecitersProvider,
          name: r'fetchRecitersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchRecitersHash,
          dependencies: FetchRecitersFamily._dependencies,
          allTransitiveDependencies:
              FetchRecitersFamily._allTransitiveDependencies,
          page: page,
        );

  FetchRecitersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
  }) : super.internal();

  final int page;

  @override
  Override overrideWith(
    FutureOr<List<Reciter>> Function(FetchRecitersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchRecitersProvider._internal(
        (ref) => create(ref as FetchRecitersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Reciter>> createElement() {
    return _FetchRecitersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchRecitersProvider && other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchRecitersRef on AutoDisposeFutureProviderRef<List<Reciter>> {
  /// The parameter `page` of this provider.
  int get page;
}

class _FetchRecitersProviderElement
    extends AutoDisposeFutureProviderElement<List<Reciter>>
    with FetchRecitersRef {
  _FetchRecitersProviderElement(super.provider);

  @override
  int get page => (origin as FetchRecitersProvider).page;
}

String _$searchReciterHash() => r'8776b23eab1a9593dfc1ad23c7eb0fe0c37d6bca';

/// See also [searchReciter].
@ProviderFor(searchReciter)
const searchReciterProvider = SearchReciterFamily();

/// See also [searchReciter].
class SearchReciterFamily extends Family<AsyncValue<List<Reciter>>> {
  /// See also [searchReciter].
  const SearchReciterFamily();

  /// See also [searchReciter].
  SearchReciterProvider call({
    String? query,
  }) {
    return SearchReciterProvider(
      query: query,
    );
  }

  @override
  SearchReciterProvider getProviderOverride(
    covariant SearchReciterProvider provider,
  ) {
    return call(
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
  String? get name => r'searchReciterProvider';
}

/// See also [searchReciter].
class SearchReciterProvider extends AutoDisposeFutureProvider<List<Reciter>> {
  /// See also [searchReciter].
  SearchReciterProvider({
    String? query,
  }) : this._internal(
          (ref) => searchReciter(
            ref as SearchReciterRef,
            query: query,
          ),
          from: searchReciterProvider,
          name: r'searchReciterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchReciterHash,
          dependencies: SearchReciterFamily._dependencies,
          allTransitiveDependencies:
              SearchReciterFamily._allTransitiveDependencies,
          query: query,
        );

  SearchReciterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String? query;

  @override
  Override overrideWith(
    FutureOr<List<Reciter>> Function(SearchReciterRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchReciterProvider._internal(
        (ref) => create(ref as SearchReciterRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Reciter>> createElement() {
    return _SearchReciterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchReciterProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchReciterRef on AutoDisposeFutureProviderRef<List<Reciter>> {
  /// The parameter `query` of this provider.
  String? get query;
}

class _SearchReciterProviderElement
    extends AutoDisposeFutureProviderElement<List<Reciter>>
    with SearchReciterRef {
  _SearchReciterProviderElement(super.provider);

  @override
  String? get query => (origin as SearchReciterProvider).query;
}

String _$userReciterHash() => r'c04baa62aa2342241249567289e26880333d1db3';

/// A [UserReciter] class to manage the state of the currently selected reciter.
/// Example:
/// ```dart
/// final reciter = ref.watch(userReciterProvider);
/// ```
///
/// To change the reciter:
/// ```dart
/// ref.read(userReciterProvider.notifier).setReciter(newReciter);
/// ```
///
/// Copied from [UserReciter].
@ProviderFor(UserReciter)
final userReciterProvider = NotifierProvider<UserReciter, Reciter>.internal(
  UserReciter.new,
  name: r'userReciterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userReciterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserReciter = Notifier<Reciter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

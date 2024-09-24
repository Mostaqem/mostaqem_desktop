// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchUthmaniScriptHash() =>
    r'c3a45f8daf43e2543c5e34dec0e997481ec05c0d';

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

/// See also [fetchUthmaniScript].
@ProviderFor(fetchUthmaniScript)
const fetchUthmaniScriptProvider = FetchUthmaniScriptFamily();

/// See also [fetchUthmaniScript].
class FetchUthmaniScriptFamily extends Family<AsyncValue<List<Script>>> {
  /// See also [fetchUthmaniScript].
  const FetchUthmaniScriptFamily();

  /// See also [fetchUthmaniScript].
  FetchUthmaniScriptProvider call({
    required int surahID,
    required int page,
    String? query,
  }) {
    return FetchUthmaniScriptProvider(
      surahID: surahID,
      page: page,
      query: query,
    );
  }

  @override
  FetchUthmaniScriptProvider getProviderOverride(
    covariant FetchUthmaniScriptProvider provider,
  ) {
    return call(
      surahID: provider.surahID,
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
  String? get name => r'fetchUthmaniScriptProvider';
}

/// See also [fetchUthmaniScript].
class FetchUthmaniScriptProvider extends FutureProvider<List<Script>> {
  /// See also [fetchUthmaniScript].
  FetchUthmaniScriptProvider({
    required int surahID,
    required int page,
    String? query,
  }) : this._internal(
          (ref) => fetchUthmaniScript(
            ref as FetchUthmaniScriptRef,
            surahID: surahID,
            page: page,
            query: query,
          ),
          from: fetchUthmaniScriptProvider,
          name: r'fetchUthmaniScriptProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchUthmaniScriptHash,
          dependencies: FetchUthmaniScriptFamily._dependencies,
          allTransitiveDependencies:
              FetchUthmaniScriptFamily._allTransitiveDependencies,
          surahID: surahID,
          page: page,
          query: query,
        );

  FetchUthmaniScriptProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.surahID,
    required this.page,
    required this.query,
  }) : super.internal();

  final int surahID;
  final int page;
  final String? query;

  @override
  Override overrideWith(
    FutureOr<List<Script>> Function(FetchUthmaniScriptRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchUthmaniScriptProvider._internal(
        (ref) => create(ref as FetchUthmaniScriptRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        surahID: surahID,
        page: page,
        query: query,
      ),
    );
  }

  @override
  FutureProviderElement<List<Script>> createElement() {
    return _FetchUthmaniScriptProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchUthmaniScriptProvider &&
        other.surahID == surahID &&
        other.page == page &&
        other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, surahID.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchUthmaniScriptRef on FutureProviderRef<List<Script>> {
  /// The parameter `surahID` of this provider.
  int get surahID;

  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `query` of this provider.
  String? get query;
}

class _FetchUthmaniScriptProviderElement
    extends FutureProviderElement<List<Script>> with FetchUthmaniScriptRef {
  _FetchUthmaniScriptProviderElement(super.provider);

  @override
  int get surahID => (origin as FetchUthmaniScriptProvider).surahID;
  @override
  int get page => (origin as FetchUthmaniScriptProvider).page;
  @override
  String? get query => (origin as FetchUthmaniScriptProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

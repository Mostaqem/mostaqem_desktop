// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reciters_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchReciterHash() => r'51500c797c1c6493e619647ea4f17afb0f92e57b';

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

String _$fetchRecitersHash() => r'7e21945623b4f35d11ac79996e161608c2f244b9';

/// See also [fetchReciters].
@ProviderFor(fetchReciters)
final fetchRecitersProvider = AutoDisposeFutureProvider<List<Reciter>>.internal(
  fetchReciters,
  name: r'fetchRecitersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchRecitersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchRecitersRef = AutoDisposeFutureProviderRef<List<Reciter>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

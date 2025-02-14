// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchQuranHash() => r'f00e360ecc78857417da9514b038fed65f91e935';

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

/// See also [fetchQuran].
@ProviderFor(fetchQuran)
const fetchQuranProvider = FetchQuranFamily();

/// See also [fetchQuran].
class FetchQuranFamily extends Family<AsyncValue<List<Script>>> {
  /// See also [fetchQuran].
  const FetchQuranFamily();

  /// See also [fetchQuran].
  FetchQuranProvider call({required int surahID}) {
    return FetchQuranProvider(surahID: surahID);
  }

  @override
  FetchQuranProvider getProviderOverride(
    covariant FetchQuranProvider provider,
  ) {
    return call(surahID: provider.surahID);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchQuranProvider';
}

/// See also [fetchQuran].
class FetchQuranProvider extends AutoDisposeFutureProvider<List<Script>> {
  /// See also [fetchQuran].
  FetchQuranProvider({required int surahID})
    : this._internal(
        (ref) => fetchQuran(ref as FetchQuranRef, surahID: surahID),
        from: fetchQuranProvider,
        name: r'fetchQuranProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$fetchQuranHash,
        dependencies: FetchQuranFamily._dependencies,
        allTransitiveDependencies: FetchQuranFamily._allTransitiveDependencies,
        surahID: surahID,
      );

  FetchQuranProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.surahID,
  }) : super.internal();

  final int surahID;

  @override
  Override overrideWith(
    FutureOr<List<Script>> Function(FetchQuranRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchQuranProvider._internal(
        (ref) => create(ref as FetchQuranRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        surahID: surahID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Script>> createElement() {
    return _FetchQuranProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchQuranProvider && other.surahID == surahID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, surahID.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchQuranRef on AutoDisposeFutureProviderRef<List<Script>> {
  /// The parameter `surahID` of this provider.
  int get surahID;
}

class _FetchQuranProviderElement
    extends AutoDisposeFutureProviderElement<List<Script>>
    with FetchQuranRef {
  _FetchQuranProviderElement(super.provider);

  @override
  int get surahID => (origin as FetchQuranProvider).surahID;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

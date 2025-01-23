// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recitation_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchReciterRecitationHash() =>
    r'22d07b7224e9ad9583fb277f6116fa702b510e85';

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

/// See also [fetchReciterRecitation].
@ProviderFor(fetchReciterRecitation)
const fetchReciterRecitationProvider = FetchReciterRecitationFamily();

/// See also [fetchReciterRecitation].
class FetchReciterRecitationFamily
    extends Family<AsyncValue<List<Recitation>>> {
  /// See also [fetchReciterRecitation].
  const FetchReciterRecitationFamily();

  /// See also [fetchReciterRecitation].
  FetchReciterRecitationProvider call({
    required int reciterID,
  }) {
    return FetchReciterRecitationProvider(
      reciterID: reciterID,
    );
  }

  @override
  FetchReciterRecitationProvider getProviderOverride(
    covariant FetchReciterRecitationProvider provider,
  ) {
    return call(
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
  String? get name => r'fetchReciterRecitationProvider';
}

/// See also [fetchReciterRecitation].
class FetchReciterRecitationProvider
    extends AutoDisposeFutureProvider<List<Recitation>> {
  /// See also [fetchReciterRecitation].
  FetchReciterRecitationProvider({
    required int reciterID,
  }) : this._internal(
          (ref) => fetchReciterRecitation(
            ref as FetchReciterRecitationRef,
            reciterID: reciterID,
          ),
          from: fetchReciterRecitationProvider,
          name: r'fetchReciterRecitationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchReciterRecitationHash,
          dependencies: FetchReciterRecitationFamily._dependencies,
          allTransitiveDependencies:
              FetchReciterRecitationFamily._allTransitiveDependencies,
          reciterID: reciterID,
        );

  FetchReciterRecitationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.reciterID,
  }) : super.internal();

  final int reciterID;

  @override
  Override overrideWith(
    FutureOr<List<Recitation>> Function(FetchReciterRecitationRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchReciterRecitationProvider._internal(
        (ref) => create(ref as FetchReciterRecitationRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        reciterID: reciterID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Recitation>> createElement() {
    return _FetchReciterRecitationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchReciterRecitationProvider &&
        other.reciterID == reciterID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, reciterID.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchReciterRecitationRef
    on AutoDisposeFutureProviderRef<List<Recitation>> {
  /// The parameter `reciterID` of this provider.
  int get reciterID;
}

class _FetchReciterRecitationProviderElement
    extends AutoDisposeFutureProviderElement<List<Recitation>>
    with FetchReciterRecitationRef {
  _FetchReciterRecitationProviderElement(super.provider);

  @override
  int get reciterID => (origin as FetchReciterRecitationProvider).reciterID;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

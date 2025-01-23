// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchNotifierHash() => r'bb9ef960ad84d1d7b7460b4e5437b2954da495bf';

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

abstract class _$SearchNotifier extends BuildlessAutoDisposeNotifier<String?> {
  late final String screenID;

  String? build(
    String screenID,
  );
}

/// See also [SearchNotifier].
@ProviderFor(SearchNotifier)
const searchNotifierProvider = SearchNotifierFamily();

/// See also [SearchNotifier].
class SearchNotifierFamily extends Family<String?> {
  /// See also [SearchNotifier].
  const SearchNotifierFamily();

  /// See also [SearchNotifier].
  SearchNotifierProvider call(
    String screenID,
  ) {
    return SearchNotifierProvider(
      screenID,
    );
  }

  @override
  SearchNotifierProvider getProviderOverride(
    covariant SearchNotifierProvider provider,
  ) {
    return call(
      provider.screenID,
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
  String? get name => r'searchNotifierProvider';
}

/// See also [SearchNotifier].
class SearchNotifierProvider
    extends AutoDisposeNotifierProviderImpl<SearchNotifier, String?> {
  /// See also [SearchNotifier].
  SearchNotifierProvider(
    String screenID,
  ) : this._internal(
          () => SearchNotifier()..screenID = screenID,
          from: searchNotifierProvider,
          name: r'searchNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchNotifierHash,
          dependencies: SearchNotifierFamily._dependencies,
          allTransitiveDependencies:
              SearchNotifierFamily._allTransitiveDependencies,
          screenID: screenID,
        );

  SearchNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.screenID,
  }) : super.internal();

  final String screenID;

  @override
  String? runNotifierBuild(
    covariant SearchNotifier notifier,
  ) {
    return notifier.build(
      screenID,
    );
  }

  @override
  Override overrideWith(SearchNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: SearchNotifierProvider._internal(
        () => create()..screenID = screenID,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        screenID: screenID,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SearchNotifier, String?> createElement() {
    return _SearchNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchNotifierProvider && other.screenID == screenID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, screenID.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchNotifierRef on AutoDisposeNotifierProviderRef<String?> {
  /// The parameter `screenID` of this provider.
  String get screenID;
}

class _SearchNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<SearchNotifier, String?>
    with SearchNotifierRef {
  _SearchNotifierProviderElement(super.provider);

  @override
  String get screenID => (origin as SearchNotifierProvider).screenID;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

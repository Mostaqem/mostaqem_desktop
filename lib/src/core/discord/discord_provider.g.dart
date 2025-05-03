// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discord_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$updateRPCDiscordHash() => r'99335013b6251f586b4c07459a16406878c27880';

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

/// See also [updateRPCDiscord].
@ProviderFor(updateRPCDiscord)
const updateRPCDiscordProvider = UpdateRPCDiscordFamily();

/// See also [updateRPCDiscord].
class UpdateRPCDiscordFamily extends Family<AsyncValue<void>> {
  /// See also [updateRPCDiscord].
  const UpdateRPCDiscordFamily();

  /// See also [updateRPCDiscord].
  UpdateRPCDiscordProvider call({
    required String surahName,
    required String reciter,
  }) {
    return UpdateRPCDiscordProvider(surahName: surahName, reciter: reciter);
  }

  @override
  UpdateRPCDiscordProvider getProviderOverride(
    covariant UpdateRPCDiscordProvider provider,
  ) {
    return call(surahName: provider.surahName, reciter: provider.reciter);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateRPCDiscordProvider';
}

/// See also [updateRPCDiscord].
class UpdateRPCDiscordProvider extends AutoDisposeFutureProvider<void> {
  /// See also [updateRPCDiscord].
  UpdateRPCDiscordProvider({required String surahName, required String reciter})
    : this._internal(
        (ref) => updateRPCDiscord(
          ref as UpdateRPCDiscordRef,
          surahName: surahName,
          reciter: reciter,
        ),
        from: updateRPCDiscordProvider,
        name: r'updateRPCDiscordProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$updateRPCDiscordHash,
        dependencies: UpdateRPCDiscordFamily._dependencies,
        allTransitiveDependencies:
            UpdateRPCDiscordFamily._allTransitiveDependencies,
        surahName: surahName,
        reciter: reciter,
      );

  UpdateRPCDiscordProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.surahName,
    required this.reciter,
  }) : super.internal();

  final String surahName;
  final String reciter;

  @override
  Override overrideWith(
    FutureOr<void> Function(UpdateRPCDiscordRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateRPCDiscordProvider._internal(
        (ref) => create(ref as UpdateRPCDiscordRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        surahName: surahName,
        reciter: reciter,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _UpdateRPCDiscordProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateRPCDiscordProvider &&
        other.surahName == surahName &&
        other.reciter == reciter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, surahName.hashCode);
    hash = _SystemHash.combine(hash, reciter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateRPCDiscordRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `surahName` of this provider.
  String get surahName;

  /// The parameter `reciter` of this provider.
  String get reciter;
}

class _UpdateRPCDiscordProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with UpdateRPCDiscordRef {
  _UpdateRPCDiscordProviderElement(super.provider);

  @override
  String get surahName => (origin as UpdateRPCDiscordProvider).surahName;
  @override
  String get reciter => (origin as UpdateRPCDiscordProvider).reciter;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

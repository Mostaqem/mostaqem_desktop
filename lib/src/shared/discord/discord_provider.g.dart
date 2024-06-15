// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discord_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$updateRPCDiscordHash() => r'df68cc13d748113570a61478c466cf02a41701f9';

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
class UpdateRPCDiscordFamily extends Family<void> {
  /// See also [updateRPCDiscord].
  const UpdateRPCDiscordFamily();

  /// See also [updateRPCDiscord].
  UpdateRPCDiscordProvider call({
    required String surahName,
  }) {
    return UpdateRPCDiscordProvider(
      surahName: surahName,
    );
  }

  @override
  UpdateRPCDiscordProvider getProviderOverride(
    covariant UpdateRPCDiscordProvider provider,
  ) {
    return call(
      surahName: provider.surahName,
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
  String? get name => r'updateRPCDiscordProvider';
}

/// See also [updateRPCDiscord].
class UpdateRPCDiscordProvider extends AutoDisposeProvider<void> {
  /// See also [updateRPCDiscord].
  UpdateRPCDiscordProvider({
    required String surahName,
  }) : this._internal(
          (ref) => updateRPCDiscord(
            ref as UpdateRPCDiscordRef,
            surahName: surahName,
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
        );

  UpdateRPCDiscordProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.surahName,
  }) : super.internal();

  final String surahName;

  @override
  Override overrideWith(
    void Function(UpdateRPCDiscordRef provider) create,
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
      ),
    );
  }

  @override
  AutoDisposeProviderElement<void> createElement() {
    return _UpdateRPCDiscordProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateRPCDiscordProvider && other.surahName == surahName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, surahName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UpdateRPCDiscordRef on AutoDisposeProviderRef<void> {
  /// The parameter `surahName` of this provider.
  String get surahName;
}

class _UpdateRPCDiscordProviderElement extends AutoDisposeProviderElement<void>
    with UpdateRPCDiscordRef {
  _UpdateRPCDiscordProviderElement(super.provider);

  @override
  String get surahName => (origin as UpdateRPCDiscordProvider).surahName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

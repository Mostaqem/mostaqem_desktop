// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discord_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$updateRPCDiscordHash() => r'8208cc7ceebd4f174a647c43ff81c9dff2fad2be';

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
    required int position,
    required int duration,
    required String reciter,
  }) {
    return UpdateRPCDiscordProvider(
      surahName: surahName,
      position: position,
      duration: duration,
      reciter: reciter,
    );
  }

  @override
  UpdateRPCDiscordProvider getProviderOverride(
    covariant UpdateRPCDiscordProvider provider,
  ) {
    return call(
      surahName: provider.surahName,
      position: provider.position,
      duration: provider.duration,
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
  String? get name => r'updateRPCDiscordProvider';
}

/// See also [updateRPCDiscord].
class UpdateRPCDiscordProvider extends AutoDisposeProvider<void> {
  /// See also [updateRPCDiscord].
  UpdateRPCDiscordProvider({
    required String surahName,
    required int position,
    required int duration,
    required String reciter,
  }) : this._internal(
          (ref) => updateRPCDiscord(
            ref as UpdateRPCDiscordRef,
            surahName: surahName,
            position: position,
            duration: duration,
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
          position: position,
          duration: duration,
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
    required this.position,
    required this.duration,
    required this.reciter,
  }) : super.internal();

  final String surahName;
  final int position;
  final int duration;
  final String reciter;

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
        position: position,
        duration: duration,
        reciter: reciter,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<void> createElement() {
    return _UpdateRPCDiscordProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateRPCDiscordProvider &&
        other.surahName == surahName &&
        other.position == position &&
        other.duration == duration &&
        other.reciter == reciter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, surahName.hashCode);
    hash = _SystemHash.combine(hash, position.hashCode);
    hash = _SystemHash.combine(hash, duration.hashCode);
    hash = _SystemHash.combine(hash, reciter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateRPCDiscordRef on AutoDisposeProviderRef<void> {
  /// The parameter `surahName` of this provider.
  String get surahName;

  /// The parameter `position` of this provider.
  int get position;

  /// The parameter `duration` of this provider.
  int get duration;

  /// The parameter `reciter` of this provider.
  String get reciter;
}

class _UpdateRPCDiscordProviderElement extends AutoDisposeProviderElement<void>
    with UpdateRPCDiscordRef {
  _UpdateRPCDiscordProviderElement(super.provider);

  @override
  String get surahName => (origin as UpdateRPCDiscordProvider).surahName;
  @override
  int get position => (origin as UpdateRPCDiscordProvider).position;
  @override
  int get duration => (origin as UpdateRPCDiscordProvider).duration;
  @override
  String get reciter => (origin as UpdateRPCDiscordProvider).reciter;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'startup_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$startupNotifierHash() => r'789cde3b0045032366501643eaa734090f26e93d';

/// See also [StartupNotifier].
@ProviderFor(StartupNotifier)
final startupNotifierProvider =
    AutoDisposeAsyncNotifierProvider<StartupNotifier, String>.internal(
  StartupNotifier.new,
  name: r'startupNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$startupNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$StartupNotifier = AutoDisposeAsyncNotifier<String>;
String _$minimizeNotifierHash() => r'9e872a1c163e93226c992f33c7ebf2adebc4943e';

/// See also [MinimizeNotifier].
@ProviderFor(MinimizeNotifier)
final minimizeNotifierProvider =
    AutoDisposeNotifierProvider<MinimizeNotifier, bool>.internal(
  MinimizeNotifier.new,
  name: r'minimizeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$minimizeNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MinimizeNotifier = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

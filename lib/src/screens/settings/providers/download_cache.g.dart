// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_cache.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$downloadDestinationHash() =>
    r'b1ac73e5468fa36534a22ba781670f08abf9746e';

/// See also [downloadDestination].
@ProviderFor(downloadDestination)
final downloadDestinationProvider = FutureProvider<String>.internal(
  downloadDestination,
  name: r'downloadDestinationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$downloadDestinationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DownloadDestinationRef = FutureProviderRef<String>;
String _$downloadCacheHash() => r'e39be20c87f2397c43700350a057e65d6600a0e7';

/// See also [DownloadCache].
@ProviderFor(DownloadCache)
final downloadCacheProvider = NotifierProvider<DownloadCache, String?>.internal(
  DownloadCache.new,
  name: r'downloadCacheProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$downloadCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DownloadCache = Notifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github/github.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mostaqem/src/shared/internet_checker/network_checker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

enum UpdateState { available, notAvailable }

class PackageRepository {
  PackageRepository(this.ref);

  Future<PackageInfo> getPackageInfo() => PackageInfo.fromPlatform();
  Ref ref;
  final GitHub _github = GitHub();
  final _githubRepoSlug = RepositorySlug.full('Mostaqem/mostaqem_desktop');

  Future<String> currentVersion() async {
    final info = await getPackageInfo();
    return info.version;
  }

  int getExtendedVersionNumber(String version) {
    final versionCells = version.split('.');
    final versionNumbers = versionCells.map(int.parse).toList();
    return versionNumbers[0] * 10000 +
        versionNumbers[1] * 100 +
        versionNumbers[2];
  }

  Future<UpdateState> checkUpdate() async {
    final networkState = await ref.read(getConnectionProvider.future);
    if (networkState == InternetConnectionStatus.disconnected) {
      return UpdateState.notAvailable;
    }
    final version = await currentVersion();

    final latestRelease = await _github.repositories.getLatestRelease(
      _githubRepoSlug,
    );
    final latestVersion = latestRelease.tagName?.substring(1);
    if (latestVersion == null) return UpdateState.notAvailable;
    final currentV = getExtendedVersionNumber(version);
    final latestV = getExtendedVersionNumber(latestVersion);

    return currentV < latestV
        ? UpdateState.available
        : UpdateState.notAvailable;
  }

  Future<void> downloadUpdate() async {
    final latestRelease = await _github.repositories.getLatestRelease(
      _githubRepoSlug,
    );

    final os = Platform.operatingSystem;
    String? installUrl;

    switch (os) {
      case 'windows':
        installUrl =
            latestRelease.assets!
                .firstWhere((element) => element.name!.contains('.exe'))
                .browserDownloadUrl;
        if (installUrl == null) return;
        await launchUrlString(installUrl);
      case 'linux':
        await launchUrlString(latestRelease.htmlUrl!);
      case 'macos':
        installUrl =
            latestRelease.assets!
                .firstWhere((element) => element.name!.contains('.dmg'))
                .browserDownloadUrl;
        if (installUrl == null) return;
       await launchUrlString(installUrl);
    }
  }
}

final packageRepoProvider = Provider<PackageRepository>(PackageRepository.new);

final downloadUpdateProvider = FutureProvider.autoDispose<void>((ref) async {
  final repo = ref.watch(packageRepoProvider);
  final checkUpdate = await ref.watch(checkUpdateProvider.future);
  if (checkUpdate == UpdateState.available) {
    return repo.downloadUpdate();
  }
  return;
});

final checkUpdateProvider = FutureProvider.autoDispose<UpdateState>((
  ref,
) async {
  final repo = ref.watch(packageRepoProvider);
  return repo.checkUpdate();
});

final getCurrentVersionProvider = FutureProvider.autoDispose<String>((
  ref,
) async {
  final repo = ref.watch(packageRepoProvider);
  return repo.currentVersion();
});

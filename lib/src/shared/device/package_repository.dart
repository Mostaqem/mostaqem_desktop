import 'dart:io';

import 'package:github/github.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

enum UpdateState {
  available,
  notAvailable;
}

class PackageRepository {
  Future<PackageInfo> getPackageInfo() => PackageInfo.fromPlatform();
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
    final version = await currentVersion();

    final latestRelease =
        await _github.repositories.getLatestRelease(_githubRepoSlug);
    final latestVersion = latestRelease.tagName?.substring(1);
    if (latestVersion == null) return UpdateState.notAvailable;
    final currentV = getExtendedVersionNumber(version);
    final latestV = getExtendedVersionNumber(latestVersion);

    return currentV < latestV
        ? UpdateState.available
        : UpdateState.notAvailable;
  }

  Future<void> downloadUpdate() async {
    final latestRelease =
        await _github.repositories.getLatestRelease(_githubRepoSlug);

    final os = Platform.operatingSystem;
    String? installUrl;

    switch (os) {
      case 'windows':
        installUrl = latestRelease.assets!
            .firstWhere((element) => element.name!.contains('.exe'))
            .browserDownloadUrl;
        if (installUrl == null) return;
        await launchUrlString(installUrl);
      case 'linux':
        await launchUrlString(latestRelease.htmlUrl!);
    }
  }
}

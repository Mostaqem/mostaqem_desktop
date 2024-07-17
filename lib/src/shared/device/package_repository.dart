import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:github/github.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 10000 + versionCells[1] * 100 + versionCells[2];
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
      case "windows":
        installUrl = latestRelease.assets!
            .firstWhere((element) => element.name!.contains('.exe'))
            .browserDownloadUrl;
        if (installUrl == null) return;
        await launchUrlString(installUrl);
        break;
      case "linux":
        //TODO: Download update for Linux
        break;
    }
  }
}

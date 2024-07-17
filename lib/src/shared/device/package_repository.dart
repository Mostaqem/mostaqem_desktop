import 'package:package_info_plus/package_info_plus.dart';

class PackageRepository {
  Future<PackageInfo> getPackageInfo() => PackageInfo.fromPlatform();

  Future<String> currentVersion() async {
    final info = await getPackageInfo();
    return info.version;
  }
}

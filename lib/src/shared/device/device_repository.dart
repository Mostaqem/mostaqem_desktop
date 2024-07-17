import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceRepository {
  final _deviceInfo = DeviceInfoPlugin();

  Future<String> deviceInfo() async {
    if (Platform.isWindows) {
      final winInfo = await _deviceInfo.windowsInfo;
      return "Windows ${winInfo.majorVersion}";
    }
    if (Platform.isLinux) {
      final linuxInfo = await _deviceInfo.linuxInfo;
      return "Linux ${linuxInfo.versionCodename}";
    }
    return "";
  }

  Future<String> deviceID() async {
    if (Platform.isWindows) {
      final winInfo = await _deviceInfo.windowsInfo;
      return winInfo.buildLab.toString();
    }
    if (Platform.isLinux) {
      final linuxInfo = await _deviceInfo.linuxInfo;
      return linuxInfo.versionId!;
    }
    return "";
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/env/env.dart';
import 'package:mostaqem/src/screens/home/home_screen.dart';

import 'package:mostaqem/src/screens/offline/offline.dart';
import 'package:universal_platform/universal_platform.dart';

class Screen {
  Screen({
    required this.icon,
    required this.label,
    required this.widget,
    required this.selectedIcon,
  });
  Icon icon;
  Icon selectedIcon;
  String label;
  Widget widget;
}

List<Screen> _childrenScreens = [
  Screen(
    icon: const Icon(Icons.home_outlined),
    label: 'الرئيسية',
    selectedIcon: const Icon(Icons.home),
    widget: HomeScreen(),
  ),
  Screen(
    icon: const Icon(Icons.folder_outlined),
    selectedIcon: const Icon(Icons.folder),
    label: 'التحميلات',
    widget: const DownloadsScreen(),
  ),
];
// make if the platform is web not add offlien screen
void ignoreDownloadScreenIfWeb() {
  if (UniversalPlatform.isWeb) {
    _childrenScreens
      ..removeLast()
      ..add(
        Screen(
          icon:
              const Icon(Icons.info_outline_rounded, color: Colors.transparent),
          selectedIcon: const Icon(Icons.info),
          label: Constants.fakeLableString,
          widget: const DownloadsScreen(),
        ),
      );
  }
}

// add offline screen

final childrenProvider = StateProvider<List<Screen>>((ref) => _childrenScreens);

final indexScreenProvider = StateProvider<int>((ref) => 0);

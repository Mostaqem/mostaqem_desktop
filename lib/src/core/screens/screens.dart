import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/broadcast/broadcast.dart';
import 'package:mostaqem/src/screens/home/home_screen.dart';
import 'package:mostaqem/src/screens/offline/offline.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';

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

Set<Screen> getChildrenScreens(BuildContext context) {
  return {
    Screen(
      icon: const Icon(Icons.home_outlined),
      label: context.tr.home,
      selectedIcon: const Icon(Icons.home),
      widget: HomeScreen(),
    ),
    Screen(
      icon: const Icon(Icons.folder_outlined),
      selectedIcon: const Icon(Icons.folder),
      label: context.tr.downloads,
      widget: const DownloadsScreen(),
    ),
    Screen(
      icon: const Icon(Icons.radio_outlined),
      selectedIcon: const Icon(Icons.radio_outlined),
      label: context.tr.broadcasts,
      widget: const BroadcastScreen(),
    ),
  };
}

final childrenProvider = StateProvider<Set<Screen>>((ref) => const {});

final indexScreenProvider = StateProvider<int>((ref) => 0);

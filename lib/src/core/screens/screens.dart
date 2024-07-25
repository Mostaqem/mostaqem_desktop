import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/home/home_screen.dart';

import '../../screens/offline/offline.dart';

class Screen {
  Icon icon;
  Icon selectedIcon;
  String label;
  Widget widget;

  Screen(
      {required this.icon,
      required this.label,
      required this.widget,
      required this.selectedIcon});
}

final List<Screen> _childrenScreens = [
  Screen(
      icon: const Icon(Icons.home_outlined),
      label: "الرئيسية",
      selectedIcon: const Icon(Icons.home),
      widget: HomeScreen()),
  Screen(
      icon: const Icon(Icons.folder_outlined),
      selectedIcon: const Icon(Icons.folder),
      label: "التحميلات",
      widget: const DownloadsScreen()),
];

final childrenProvider = StateProvider<List<Screen>>((ref) => _childrenScreens);

final indexScreenProvider = StateProvider<int>((ref) => 0);
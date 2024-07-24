import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Screen {
  Icon icon;
  Icon selectedIcon;
  String label;

  Screen({required this.icon, required this.label, required this.selectedIcon});
}

final List<Screen> _childrenScreens = [
  Screen(
    icon: const Icon(Icons.home_outlined),
    label: "الرئيسية",
    selectedIcon: const Icon(Icons.home),
  ),
  Screen(
    icon: const Icon(Icons.folder_outlined),
    selectedIcon: const Icon(Icons.folder),
    label: "التحميلات",
  ),
];

final childrenProvider = StateProvider<List<Screen>>((ref) => _childrenScreens);

final indexScreenProvider = StateProvider<int>((ref) => 0);

String getCurrentRoutePath(BuildContext context) {
  return GoRouter.of(context).routeInformationProvider.value.uri.path;
}


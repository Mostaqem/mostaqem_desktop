import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';
import 'package:mostaqem/src/screens/broadcast/broadcast.dart';
import 'package:mostaqem/src/screens/favorites/favorites_screen.dart';
import 'package:mostaqem/src/screens/home/home_screen.dart';
import 'package:mostaqem/src/screens/offline/offline.dart';

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
      widget: const HomeScreen(),
    ),
    Screen(
      icon: const Icon(Icons.favorite_border_outlined),
      selectedIcon: const Icon(Icons.favorite),
      label: 'Favorites',
      widget: const FavoritesScreen(),
    ),
    Screen(
      icon: const Icon(Icons.folder_outlined),
      selectedIcon: const Icon(Icons.folder),
      label: context.tr.downloads,
      widget: const DownloadsScreen(),
    ),
  };
}

final childrenProvider = StateProvider<Set<Screen>>((ref) => const {});

final indexScreenProvider = StateProvider<int>((ref) => 0);

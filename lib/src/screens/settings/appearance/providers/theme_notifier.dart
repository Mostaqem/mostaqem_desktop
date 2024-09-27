import 'package:flutter/material.dart';
import 'package:mostaqem/src/shared/cache/cache_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_notifier.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeMode build() {
    final getUserTheme = CacheHelper.getString('theme');
    if (getUserTheme == null) {
      return ThemeMode.system;
    }
    return getTheme(getUserTheme);
  }

  void setTheme(ThemeMode theme) {
    state = theme;
    CacheHelper.setString('theme', theme.name);
  }

  ThemeMode getTheme(String theme) {
    switch (theme) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}

final themeProvider =
    Provider.autoDispose<ThemeData>((ref) => throw UnimplementedError());

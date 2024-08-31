import 'package:flutter/material.dart';
import 'package:mostaqem/src/shared/cache/cache_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'apperance_providers.g.dart';

@riverpod
class UserSeedColor extends _$UserSeedColor {
  @override
  Color? build() {
    final getColor = CacheHelper.getInt('color');
    if (getColor == null) {
      return null;
    }
    final userColor = Color(getColor);
    return userColor;
  }

  void setColor(Color color) {
    state = color;
    CacheHelper.setInt('color', color.value);
  }

  void clear() {
    state = null;
    CacheHelper.remove('color');
  }
}

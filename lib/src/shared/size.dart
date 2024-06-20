import 'dart:ui';

import 'package:flutter/material.dart';

class DesktopSize {
  late final Size size;
  DesktopSize() {
    _init();
  }

  _init() {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    size = view.physicalSize / view.devicePixelRatio;
  }

  Size get initSize => const Size(1280, 780);
}

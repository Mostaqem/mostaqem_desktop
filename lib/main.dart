import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
  doWhenWindowReady(() {
    const initialSize = Size(1440, 860);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.title = "Mostaqem";
    appWindow.alignment = Alignment.center;

    appWindow.show();
  });
}

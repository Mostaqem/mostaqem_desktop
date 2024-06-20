import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/shared/size.dart';

import 'src/app.dart';
import 'package:discord_rpc/discord_rpc.dart';

void main() {
  DiscordRPC.initialize();
  runApp(const ProviderScope(child: MyApp()));

  doWhenWindowReady(() {
    appWindow.minSize = const Size(1000, 850 / 2);

    appWindow.size = DesktopSize().initSize;
    appWindow.title = "Mostaqem";
    appWindow.alignment = Alignment.center;

    appWindow.show();
  });
}

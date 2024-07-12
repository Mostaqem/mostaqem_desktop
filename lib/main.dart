import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:media_kit/media_kit.dart'; // Provides [Player], [Media], [Playlist] etc.

import 'src/app.dart';
import 'package:discord_rpc/discord_rpc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DiscordRPC.initialize();
  await windowManager.ensureInitialized();
  MediaKit.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1280, 780),
    minimumSize: Size(800, 500),
    center: true,
    title: "Mostaqem",
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const ProviderScope(child: MyApp()));
}

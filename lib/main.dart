import 'package:discord_rpc/discord_rpc.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart'; // Provides [Player], [Media], [Playlist] etc.
import 'package:metadata_god/metadata_god.dart';
import 'package:mostaqem/src/app.dart';
import 'package:mostaqem/src/shared/cache/cache_helper.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DiscordRPC.initialize();
  await windowManager.ensureInitialized();

  MediaKit.ensureInitialized();
  await CacheHelper.init();
  MetadataGod.initialize();

  runApp(const Mostaqem());

  const windowOptions = WindowOptions(
    size: Size(1280, 780),
    minimumSize: Size(800, 500),
    center: true,
    title: 'Mostaqem',
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}

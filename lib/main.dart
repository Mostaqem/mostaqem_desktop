import 'dart:io';

import 'package:discord_rpc/discord_rpc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:mostaqem/src/app.dart';
import 'package:mostaqem/src/screens/initial/inital_loading.dart';
import 'package:mostaqem/src/shared/cache/cache_helper.dart';
import 'package:mostaqem/src/shared/http_override/http_override.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  await CacheHelper.init();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(child: InitialLoading()),
  );
  HttpOverrides.global = MyHttpOverrides();
  if (!Platform.isMacOS) {
    DiscordRPC.initialize();
  }
  await windowManager.ensureInitialized();

  MediaKit.ensureInitialized();
  MetadataGod.initialize();

  final windowOptions = WindowOptions(
    size: const Size(1280, 780),
    minimumSize: const Size(800, 500),
    center: true,
    title: 'Mostaqem',
    backgroundColor: Colors.transparent,
    titleBarStyle: Platform.isWindows ? TitleBarStyle.hidden : TitleBarStyle.normal,
  );
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  await Future<void>.delayed(const Duration(seconds: 1));
  runApp(const Mostaqem());
}

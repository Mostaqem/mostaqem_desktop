// ignore_for_file: missing_provider_scope
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_discord_rpc/flutter_discord_rpc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:media_kit/media_kit.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:mostaqem/src/app.dart';
import 'package:mostaqem/src/core/env/env.dart';
import 'package:mostaqem/src/screens/initial/inital_loading.dart';
import 'package:mostaqem/src/shared/cache/cache_helper.dart';
import 'package:mostaqem/src/shared/http_override/http_override.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  runApp(ProviderScope(child: InitialLoading()));
  HttpOverrides.global = MyHttpOverrides();

  launchAtStartup.setup(
    appName: 'Mostaqem',
    appPath: Platform.resolvedExecutable,
  );

  await FlutterDiscordRPC.initialize(Constants.discordAPPID);

  await windowManager.ensureInitialized();

  MediaKit.ensureInitialized();
  await MetadataGod.initialize();

  final windowOptions = WindowOptions(
    size: const Size(1280, 780),
    minimumSize: const Size(800, 500),
    center: true,
    title: 'Mostaqem',
    backgroundColor: Colors.transparent,
    titleBarStyle:
        Platform.isWindows ? TitleBarStyle.hidden : TitleBarStyle.normal,
  );
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  await Future<void>.delayed(const Duration(seconds: 1));
  runApp(const Mostaqem());
}

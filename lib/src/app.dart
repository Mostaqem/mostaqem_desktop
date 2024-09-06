import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/core/theme/theme.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/download_manager.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/player_widget.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/recitation_widget.dart';
import 'package:mostaqem/src/screens/settings/appearance/providers/apperance_providers.dart';
import 'package:mostaqem/src/screens/settings/appearance/providers/theme_notifier.dart';
import 'package:mostaqem/src/shared/widgets/shortcuts/shortcuts_widgets.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final userSeedColor = ref.watch(userSeedColorProvider);
    final userTheme = ref.watch(themeNotifierProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'SA'),
        Locale('en', 'US'),
      ],
      locale: const Locale('ar', 'SA'),
      builder: (context, child) {
        return Material(
          child: AppShortcuts(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                child!,
                SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Overlay(
                      initialEntries: [
                        OverlayEntry(
                          builder: (context) => const PlayerWidget(),
                        ),
                      ],
                    ),
                  ),
                ),
                const DownloadManagerWidget(),
                const RecitationWidget(),
              ],
            ),
          ),
        );
      },
      title: 'Mostaqem',
      themeMode: userTheme,
      theme: AppTheme.userLightTheme(userSeedColor),
      darkTheme: AppTheme.userDarkTheme(userSeedColor),
    );
  }
}

class Mostaqem extends StatelessWidget {
  const Mostaqem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(child: MaterialApp(home: MyApp()));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/core/theme/theme.dart';
import 'package:mostaqem/src/shared/widgets/shortcuts.dart';

import 'screens/navigation/widgets/player_widget.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return AppShortcuts(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("en", "SA"),
          Locale("ar", "AE"),
        ],
        locale: const Locale("ar", "SA"),
        builder: (context, child) {
          return Material(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                child!,
                SizedBox(
                  height: 100,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 0),
                      child: Overlay(
                        initialEntries: [
                          OverlayEntry(
                              builder: (context) => const PlayerWidget())
                        ],
                      )),
                )
              ],
            ),
          );
        },
        title: 'Mostaqem',
        theme: AppTheme.lightTheme,
        // darkTheme: AppTheme.darkTheme
      ),
    );
  }
}

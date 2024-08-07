import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/core/theme/theme.dart';
import 'package:mostaqem/src/screens/navigation/widgets/download_manager.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player_widget.dart';
import 'package:mostaqem/src/shared/widgets/shortcuts.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'SA'),
          Locale('ar', 'AE'),
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
                            horizontal: 5,),
                        child: Overlay(
                          initialEntries: [
                            OverlayEntry(
                                builder: (context) => const PlayerWidget(),),
                          ],
                        ),),
                  ),
                  const DownloadManagerWidget(),
                ],
              ),
            ),
          );
        },
        title: 'Mostaqem',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,);
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

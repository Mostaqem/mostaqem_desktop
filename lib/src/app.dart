import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/core/theme/theme.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/download_manager.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/player_widget.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/recitation_widget.dart';
import 'package:mostaqem/src/screens/settings/appearance/providers/apperance_providers.dart';
import 'package:mostaqem/src/screens/settings/appearance/providers/theme_notifier.dart';
import 'package:mostaqem/src/shared/I10n/app_localizations.dart';
import 'package:mostaqem/src/shared/widgets/shortcuts/shortcuts_widgets.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final userSeedColor = ref.watch(userSeedColorProvider);
    final userTheme = ref.watch(themeNotifierProvider);
    final currentLang = ref.watch(localeNotifierProvider);
    return MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: I18nRepository.supportedLocales,
      locale: currentLang,
      builder: (context, child) {
        return Material(
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) {
                  return AppShortcuts(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        child!,
                        const SizedBox(height: 100, child: PlayerWidget()),
                        const DownloadManagerWidget(),
                        const RecitationWidget(),
                      ],
                    ),
                  );
                },
              ),
            ],
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
  const Mostaqem({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: ContextMenuOverlay(child: const MyApp()));
  }
}

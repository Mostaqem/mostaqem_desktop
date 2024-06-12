import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/core/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
        title: 'Mostaqeem',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme);
  }
}

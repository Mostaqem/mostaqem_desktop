import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mostaqem/src/screens/home/home_screen.dart';
import 'package:mostaqem/src/screens/navigation/navigation.dart';
import 'package:mostaqem/src/screens/reading/reading_screen.dart';
import 'package:mostaqem/src/shared/widgets/custom_license_page.dart';

import '../../screens/offline/offline.dart';
import '../../screens/reciters/reciters_screen.dart';
import '../../screens/settings/settings_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) => _router);
final _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        routes: [
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/',
            builder: (context, state) => HomeScreen(),
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/downloads',
            builder: (context, state) => const DownloadsScreen(),
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/reading',
            name: "Reading",
            builder: (context, state) => ReadingScreen(
              id: state.extra as int,
            ),
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/reciters',
            builder: (context, state) => const RecitersScreen(),
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/settings',
            builder: (context, state) => SettingsScreen(),
          ),
        ],
        builder: (context, state, child) => Navigation(child: child)),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/licenses',
      builder: (context, state) => const AppLicensePage(),
    ),
  ],
);

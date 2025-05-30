import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/navigation/navigation.dart';
import 'package:mostaqem/src/screens/occasions/occasions.dart';
import 'package:mostaqem/src/screens/queue/presentation/queue_screen.dart';
import 'package:mostaqem/src/screens/reading/reading_screen.dart';
import 'package:mostaqem/src/screens/reciters/reciters_screen.dart';
import 'package:mostaqem/src/screens/settings/settings_screen.dart';
import 'package:mostaqem/src/screens/share/share_screen.dart';
import 'package:mostaqem/src/shared/widgets/custom_license_page.dart';

class NavigationRepository {
  NavigationRepository(this.ref);
  final Ref ref;

  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        routes: [
          GoRoute(
            path: 'reciters',
            builder: (context, state) => const RecitersScreen(),
          ),
          GoRoute(
            path: 'queue',
            builder: (context, state) => const QueueScreen(),
          ),

          GoRoute(
            path: 'reading',
            name: 'Reading',
            routes: [
              GoRoute(
                name: 'Share',
                path: 'share/:surahName',
                builder: (context, state) => ShareScreen(
                  verse: state.extra! as String,
                  surahName: state.pathParameters['surahName']!,
                ),
              ),
            ],
            builder: (context, state) =>
                ReadingScreen(surah: state.extra! as Surah),
          ),
        ],
        builder: (context, state) => const Navigation(),
      ),
      GoRoute(
        path: '/licenses',
        builder: (context, state) => const AppLicensePage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/special',
        builder: (context, state) => const OccasionsScreen(),
      ),
    ],
  );

  String getCurrentRouter() {
    final lastMatch = router.routerDelegate.currentConfiguration.last;
    final matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : router.routerDelegate.currentConfiguration;
    final location = matchList.uri.toString();
    return location;
  }

  bool isNavigationStackDeep() {
    final lastMatch = router.routerDelegate.currentConfiguration.last;
    final matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : router.routerDelegate.currentConfiguration;
    return matchList.matches.length > 2;
  }

  bool canPop({required String expectedPath}) {
    final currentRoute = getCurrentRouter();
    return currentRoute == expectedPath;
  }
}

final goRouterProvider = Provider.autoDispose<GoRouter>((ref) {
  final repo = ref.watch(navigationProvider);
  return repo.router;
});

final navigationProvider = Provider.autoDispose<NavigationRepository>(
  NavigationRepository.new,
);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/navigation/navigation.dart';
import 'package:mostaqem/src/screens/queue/presentation/queue_screen.dart';
import 'package:mostaqem/src/screens/reading/reading_screen.dart';
import 'package:mostaqem/src/screens/reciters/reciters_screen.dart';
import 'package:mostaqem/src/screens/settings/settings_screen.dart';
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
            path: 'reading',
            name: 'Reading',
            builder:
                (context, state) => ReadingScreen(surah: state.extra! as Surah),
          ),
        ],
        builder: (context, state) => const Navigation(),
      ),
      GoRoute(
        path: '/reciters',
        builder: (context, state) => const RecitersScreen(),
      ),
      GoRoute(path: '/queue', builder: (context, state) => const QueueScreen()),
      GoRoute(
        path: '/licenses',
        builder: (context, state) => const AppLicensePage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );

  String getCurrentRouter() {
    final lastMatch = router.routerDelegate.currentConfiguration.last;
    final matchList =
        lastMatch is ImperativeRouteMatch
            ? lastMatch.matches
            : router.routerDelegate.currentConfiguration;
    final location = matchList.uri.toString();
    return location;
  }

  bool canPop({required String expectedPath}) {
    final currentRoute = getCurrentRouter();
    return currentRoute == expectedPath;
  }
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final repo = ref.watch(navigationProvider);
  return repo.router;
});

final navigationProvider = Provider<NavigationRepository>(
  NavigationRepository.new,
);

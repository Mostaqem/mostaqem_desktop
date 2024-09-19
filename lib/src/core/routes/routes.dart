import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mostaqem/src/screens/navigation/navigation.dart';
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
            builder: (context, state) => ReadingScreen(
              id: state.extra! as int,
            ),
          ),
        ],
        builder: (context, state) => const Navigation(),
      ),
      GoRoute(
        path: '/reciters',
        builder: (context, state) => RecitersScreen(),
      ),
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
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final repo = ref.watch(navigationProvider);
  return repo.router;
});

final navigationProvider =
    Provider<NavigationRepository>(NavigationRepository.new);

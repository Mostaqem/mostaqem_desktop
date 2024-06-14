import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mostaqem/src/screens/navigation/navigation.dart';
import 'package:mostaqem/src/screens/reading/reading_screen.dart';

import '../../screens/reciters/reciters_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) => _router);
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      routes: [
        GoRoute(
          path: 'reading',
          name: "Reading",
          builder: (context, state) => ReadingScreen(
            id: state.extra as int,
          ),
        ),
      ],
      builder: (context, state) => const Navigation(),
    ),
    GoRoute(
      path: '/reciters',
      builder: (context, state) => RecitersScreen(),
    ),
  ],
);

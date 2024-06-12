import 'package:go_router/go_router.dart';
import 'package:mostaqem/src/screens/navigation/navigation.dart';

import '../../screens/reciters/reciters_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Navigation(),
    ),
    GoRoute(
      path: '/reciters',
      builder: (context, state) => const RecitersScreen(),
    ),
  ],
);

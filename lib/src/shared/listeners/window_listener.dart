import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:window_manager/window_manager.dart';

class AppWindowListener extends WindowListener {
  final ProviderContainer container;
  AppWindowListener(this.container);
  @override
  void onWindowClose() async {
    container.invalidate(playerNotifierProvider);
    await windowManager.destroy();
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'fullscreen_kit.dart';
import 'package:mostaqem/src/screens/navigation/repository/fullscreen_kit.dart';
import 'package:universal_platform/universal_platform.dart';

final isFullScreenProvider =
    NotifierProvider<FullScreenNotifier, bool>(FullScreenNotifier.new);

class FullScreenNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void toggle({required bool value}) {
    state = value;

    if (UniversalPlatform.isWeb) {
      if (!isFullScreenWeb()) {
        requestFullScreen();
      } else {
        exitFullScreen();
      }
    } else {
      setFullScreen(value);
    }
  }

  bool isFullScreen() {
    return state;
  }
}

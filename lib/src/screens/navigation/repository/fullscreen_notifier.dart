import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:web/web.dart' as web;
import 'package:window_manager/window_manager.dart';

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
      if (web.document.fullscreenElement == null) {
        web.document.documentElement?.requestFullscreen();
      } else {
        web.document.exitFullscreen();
      }
    } else {
      windowManager.setFullScreen(value);
    }
  }

  bool isFullScreen() {
    return state;
  }
}

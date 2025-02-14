import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

final isFullScreenProvider = NotifierProvider<FullScreenNotifier, bool>(
  FullScreenNotifier.new,
);

class FullScreenNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void toggle({required bool value}) {
    state = value;
    windowManager.setFullScreen(value);
  }
}

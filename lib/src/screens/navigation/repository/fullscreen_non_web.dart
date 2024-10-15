import 'package:window_manager/window_manager.dart';

void requestFullScreen() {
  windowManager.setFullScreen(true);
}

void exitFullScreen() {
  windowManager.setFullScreen(false);
}

Future<bool> isFullScreen() {
  return windowManager.isFullScreen();
}

void setFullScreen(bool value) {
  windowManager.setFullScreen(value);
}

bool isFullScreenWeb() {
  return false;
}

import 'package:web/web.dart' as web;

void requestFullScreen() {
  web.document.documentElement?.requestFullscreen();
}

void exitFullScreen() {
  web.document.exitFullscreen();
}

bool isFullScreenWeb() {
  return web.document.fullscreenElement != null;
}


void setFullScreen(bool value) {

}

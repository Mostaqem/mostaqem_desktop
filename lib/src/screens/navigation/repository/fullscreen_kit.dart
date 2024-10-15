export 'fullscreen_stub.dart'
    if (dart.library.html) 'fullscreen_web.dart'
    if (dart.library.io) 'fullscreen_non_web.dart';

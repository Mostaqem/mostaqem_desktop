import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:web/web.dart' as web; // Add this for web

final getConnectionProvider =
    StreamProvider.autoDispose<InternetConnectionStatus>((ref) async* {
  if (UniversalPlatform.isWeb) {
    // Use browser-specific online detection
    final connectionStream = Stream.value(
      web.window.navigator.onLine == true
          ? InternetConnectionStatus.connected
          : InternetConnectionStatus.disconnected,
    );

    // Emit the status using a stream
    yield* connectionStream.debounceTime(const Duration(seconds: 2));
  } else {
    // Use InternetConnectionChecker for mobile and desktop
    final connectionChecker = InternetConnectionChecker();
    final subscription = connectionChecker.onStatusChange;
    yield* subscription.debounceTime(const Duration(seconds: 2));
  }
});

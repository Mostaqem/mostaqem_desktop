import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:web/web.dart' as web;

Stream<InternetConnectionStatus> getConnectionStream() {
  return Stream.value(
    web.window.navigator.onLine == true
        ? InternetConnectionStatus.connected
        : InternetConnectionStatus.disconnected,
  );
}

import 'package:internet_connection_checker/internet_connection_checker.dart';

Stream<InternetConnectionStatus> getConnectionStream() {
  return Stream.value(InternetConnectionStatus.connected);
}

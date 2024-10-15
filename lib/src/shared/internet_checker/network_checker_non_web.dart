import 'package:internet_connection_checker/internet_connection_checker.dart';

Stream<InternetConnectionStatus> getConnectionStream() {
  final connectionChecker = InternetConnectionChecker();
  return connectionChecker.onStatusChange;
}

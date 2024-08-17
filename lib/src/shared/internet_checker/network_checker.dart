import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkChecker {
  NetworkChecker(this.ref);
  final Ref ref;
  final connectionChecker = InternetConnectionChecker();

  Stream<InternetConnectionStatus> getConnection() {
    return connectionChecker.onStatusChange;
  }
}

final networkCheckerProvider = Provider(NetworkChecker.new);

final getConnectionProvider =
    StreamProvider<InternetConnectionStatus>((ref) async* {
  final repo = ref.watch(networkCheckerProvider);
  yield* repo.getConnection();
});

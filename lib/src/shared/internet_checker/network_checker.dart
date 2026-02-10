import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final getConnectionProvider =
    StreamProvider.autoDispose<InternetConnectionStatus>((ref) async* {
      final hasConnection =
          await InternetConnectionChecker.instance.hasConnection;
      yield hasConnection
          ? InternetConnectionStatus.connected
          : InternetConnectionStatus.disconnected;

      yield* InternetConnectionChecker.instance.onStatusChange;
    });

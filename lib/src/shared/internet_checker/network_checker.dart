import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final getConnectionProvider =
    FutureProvider.autoDispose<InternetConnectionStatus>((ref) async {
      final isConnected =
          await InternetConnectionChecker.instance.hasConnection;
      return isConnected
          ? InternetConnectionStatus.connected
          : InternetConnectionStatus.disconnected;
    });

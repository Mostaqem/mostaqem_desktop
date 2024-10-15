import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mostaqem/src/shared/internet_checker/network_checker_kit.dart';
import 'package:rxdart/rxdart.dart';

final getConnectionProvider =
    StreamProvider.autoDispose<InternetConnectionStatus>((ref) async* {
  final connectionStream = getConnectionStream();
  yield* connectionStream.debounceTime(const Duration(seconds: 2));
});

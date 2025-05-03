import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rxdart/rxdart.dart';

final getConnectionProvider =
    StreamProvider.autoDispose<InternetConnectionStatus>((ref) async* {
      final connectionChecker = InternetConnectionChecker.instance;
      final subscription = connectionChecker.onStatusChange;
      yield* subscription.debounceTime(const Duration(seconds: 2));
    });

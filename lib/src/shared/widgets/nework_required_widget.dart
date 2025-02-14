import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mostaqem/src/shared/internet_checker/network_checker.dart';

class NeworkRequiredWidget extends ConsumerWidget {
  const NeworkRequiredWidget({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networkState = ref.watch(getConnectionProvider).value;
    if (networkState == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return networkState == InternetConnectionStatus.connected
        ? child
        : const Center(child: Text('عفوا لا يوجد أنترنت'));
  }
}

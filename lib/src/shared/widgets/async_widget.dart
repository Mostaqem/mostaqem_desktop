import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncWidget<T> extends StatelessWidget {
  const AsyncWidget({
    required this.value,
    required this.data,
    super.key,
    this.loading,
  });

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget Function()? loading;
  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, st) {
        log('[ERROR]', error: e, stackTrace: st);
        return const Center(child: Text('حدث خطأ ما!'));
      },
      loading: loading ??
          () => const Center(
                heightFactor: 10,
                child: CircularProgressIndicator(),
              ),
    );
  }
}

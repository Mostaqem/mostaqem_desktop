import 'package:flutter/material.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'startup_provider.g.dart';

@riverpod
class StartupNotifier extends _$StartupNotifier {
  @override
  Future<String> build() async {
    final isEnabled = await launchAtStartup.isEnabled();

    return isEnabled ? 'دائما' : 'ابدا';
  }

  Future<void> toggle({required String value}) async {
    if (value == 'دائما') {
      state = const AsyncData('دائما');
      await launchAtStartup.enable();
    } else {
      state = const AsyncData('ابدا');

      await launchAtStartup.disable();
    }
  }
}

String getStartupValue(BuildContext context, String value) {
  if (value == 'دائما') {
    return context.tr.always;
  }
  return context.tr.never;
}

import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:mostaqem/src/shared/cache/cache_helper.dart';
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

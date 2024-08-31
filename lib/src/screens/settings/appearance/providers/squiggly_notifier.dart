import 'package:mostaqem/src/shared/cache/cache_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'squiggly_notifier.g.dart';

@riverpod
class SquigglyNotifier extends _$SquigglyNotifier {
  @override
  bool build() {
    return CacheHelper.getBool('squiggly') ?? false;
  }

  void toggle({required bool value}) {
    if (value == true) {
      state = true;
      CacheHelper.setBool('squiggly', value: true);
      return;
    }
    state = false;
    CacheHelper.remove('squiggly');
  }
}

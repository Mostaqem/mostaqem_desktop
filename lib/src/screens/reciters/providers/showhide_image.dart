import 'package:mostaqem/src/shared/cache/cache_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'showhide_image.g.dart';

@riverpod
class HideReciterImage extends _$HideReciterImage {
  @override
  bool build() {
    final cached = CacheHelper.getBool('hideReciterImage');
    return cached ?? false;
  }

  void toggle() {
    if (state == true) {
      state = false;
      CacheHelper.setBool('hideReciterImage', value: false);
    } else {
      state = true;
      CacheHelper.setBool('hideReciterImage', value: true);
    }
  }
}

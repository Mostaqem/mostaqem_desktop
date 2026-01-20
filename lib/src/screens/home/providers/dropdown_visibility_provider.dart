import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dropdown_visibility_provider.g.dart';

@riverpod
class DropdownVisibility extends _$DropdownVisibility {
  @override
  bool build() {
    return false;
  }

  void show() => state = true;
  void hide() => state = false;
  void toggle() => state = !state;
}

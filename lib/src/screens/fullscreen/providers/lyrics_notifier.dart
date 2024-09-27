import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'lyrics_notifier.g.dart';

@riverpod
class LyricsNotifier extends _$LyricsNotifier {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    if (state = false) {
      state = true;
    } else {
      state = false;
    }
  }
}

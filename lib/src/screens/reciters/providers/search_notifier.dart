// ignore_for_file: use_setters_to_change_properties

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'search_notifier.g.dart';

@riverpod
class SearchNotifier extends _$SearchNotifier {
  @override
  String? build(String screenID) {
    return null;
  }

  void setQuery(String value) {
    state = value;
  }

  void clear() {
    state = null;
  }
}

final isTypingProvider = Provider.autoDispose((ref) {
  final surahSearch =
      ref.watch(searchNotifierProvider('home'))?.isEmpty ?? false;
  final reciterSearch =
      ref.watch(searchNotifierProvider('reciter'))?.isEmpty ?? false;
  final verseSearch =
      ref.watch(searchNotifierProvider('reciter'))?.isEmpty ?? false;

  final noTyping = surahSearch || reciterSearch || verseSearch;
  return noTyping;
});

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

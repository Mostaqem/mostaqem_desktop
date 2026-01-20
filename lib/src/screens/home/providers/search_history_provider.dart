import 'dart:convert';

import 'package:mostaqem/src/screens/home/data/search_history_item.dart';
import 'package:mostaqem/src/shared/cache/cache_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_history_provider.g.dart';

@riverpod
class SearchHistory extends _$SearchHistory {
  static const String _cacheKey = 'search_history';
  static const int _maxHistoryItems = 9;

  @override
  FutureOr<List<SearchHistoryItem>> build() async {
    final cached = CacheHelper.getList(_cacheKey);
    if (cached == null) return [];

    return cached
        .map(
          (json) => SearchHistoryItem.fromJson(
            jsonDecode(json) as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<void> add(int itemId, String itemName, SearchType type) async {
    if (itemName.trim().isEmpty) return;

    await future;

    final current = state.value?.toList() ?? []
      ..removeWhere((item) => item.itemId == itemId && item.type == type)
      // Add to beginning
      ..insert(
        0,
        SearchHistoryItem(itemId: itemId, itemName: itemName, type: type),
      );

    // Keep only last 10
    if (current.length > _maxHistoryItems) {
      current.removeRange(_maxHistoryItems, current.length);
    }

    // Save to cache
    await _saveToCache(current);
    state = AsyncData(current);
  }

  Future<void> remove(SearchHistoryItem item) async {
    final current = state.value?.toList() ?? []
      ..removeWhere((i) => i.itemId == item.itemId && i.type == item.type);
    await _saveToCache(current);
    state = AsyncData(current);
  }

  Future<void> clear() async {
    await CacheHelper.remove(_cacheKey);
    state = const AsyncData([]);
  }

  Future<void> _saveToCache(List<SearchHistoryItem> items) async {
    final jsonList = items.map((item) => jsonEncode(item.toJson())).toList();
    await CacheHelper.setList(_cacheKey, jsonList);
  }
}

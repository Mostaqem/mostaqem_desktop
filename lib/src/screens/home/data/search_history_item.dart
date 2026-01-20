import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_history_item.freezed.dart';
part 'search_history_item.g.dart';

@freezed
abstract class SearchHistoryItem with _$SearchHistoryItem {
  const factory SearchHistoryItem({
    required int itemId,
    required String itemName,
    required SearchType type,
  }) = _SearchHistoryItem;

  factory SearchHistoryItem.fromJson(Map<String, dynamic> json) =>
      _$SearchHistoryItemFromJson(json);
}

enum SearchType { surah, reciter }

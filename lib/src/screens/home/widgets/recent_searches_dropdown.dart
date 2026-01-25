import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/home/data/search_history_item.dart';
import 'package:mostaqem/src/screens/home/providers/dropdown_visibility_provider.dart';
import 'package:mostaqem/src/screens/home/providers/search_history_provider.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/shared/widgets/hover_builder.dart';

class RecentSearchesDropdown extends ConsumerWidget {
  const RecentSearchesDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(searchHistoryProvider);

    return historyAsync.when(
      data: (history) {
        if (history.isEmpty) return const SizedBox.shrink();

        return Container(
          margin: const EdgeInsets.only(top: 8),
          width: 800,
          constraints: const BoxConstraints(maxHeight: 400),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Text(
                    'ما اخترته مؤخرًا',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                const Divider(height: 1),
                ...history.map((item) => _RecentSearchItem(item: item)),
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (err, stack) => const SizedBox.shrink(),
    );
  }
}

class _RecentSearchItem extends ConsumerWidget {
  const _RecentSearchItem({required this.item});

  final SearchHistoryItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        ref.read(dropdownVisibilityProvider.notifier).hide();
        if (item.type == SearchType.surah) {
          await ref.read(playerProvider.notifier).play(surahID: item.itemId);
        } else {
          // final reciter = await ref.read(
          //   fetchReciterProvider(id: item.itemId).future,
          // );
          // ref.read(userReciterProvider.notifier).setReciter(reciter);
          final surah = ref.read(currentSurahProvider);
          if (surah != null) {
            await ref.read(playerProvider.notifier).play(surahID: surah.id);
          }
        }
      },
      child: HoverBuilder(
        builder: (isHovered) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isHovered
                    ? Theme.of(context).colorScheme.scrim
                    : Colors.transparent,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.history,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.itemName,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.type == SearchType.surah ? 'سورة' : 'قارئ',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

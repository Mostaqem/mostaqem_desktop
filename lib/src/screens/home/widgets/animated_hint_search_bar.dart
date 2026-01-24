import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mostaqem/src/screens/home/data/search_history_item.dart';
import 'package:mostaqem/src/screens/home/providers/search_history_provider.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/reciters/providers/reciters_repository.dart';

class AnimatedHintSearchBar extends ConsumerStatefulWidget {
  const AnimatedHintSearchBar({
    required this.onChanged,
    required this.trailing,
    required this.hintTexts,
    super.key,
  });

  final void Function(String) onChanged;
  final List<Widget> trailing;
  final List<String> hintTexts;

  @override
  ConsumerState<AnimatedHintSearchBar> createState() =>
      _AnimatedHintSearchBarState();
}

class _AnimatedHintSearchBarState extends ConsumerState<AnimatedHintSearchBar> {
  Timer? _timer;
  int _currentHintIndex = 0;
  final SearchController _searchController = SearchController();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          _currentHintIndex = (_currentHintIndex + 1) % widget.hintTexts.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(searchHistoryProvider);

    return SearchAnchor(
      searchController: _searchController,
      viewOnChanged: (value) {
        context.pop();
      },
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          controller: controller,
          onTap: () {
            controller.openView();
          },
          onChanged: (value) {
            widget.onChanged(value);
          },
          elevation: const WidgetStatePropertyAll<double>(0),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          ),
          trailing: widget.trailing,
          hintText: widget.hintTexts[_currentHintIndex],
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return historyAsync.when(
          data: (history) {
            if (history.isEmpty) {
              return [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: Text('لا توجد عمليات بحث حديثة')),
                ),
              ];
            }
            return history.map((item) {
              return ListTile(
                leading: Icon(
                  Icons.history,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                title: Text(item.itemName),
                subtitle: Text(
                  item.type == SearchType.surah ? 'سورة' : 'قارئ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12,
                  ),
                ),
                onTap: () async {
                  controller.closeView('');

                  if (item.type == SearchType.surah) {
                    await ref
                        .read(playerProvider.notifier)
                        .play(surahID: item.itemId);
                  } else {
                    // final reciter = await ref.read(
                    //   fetchReciterProvider(id: item.itemId).future,
                    // );
                    // ref.read(userReciterProvider.notifier).setReciter(reciter);
                    final surah = ref.read(currentSurahProvider);
                    if (surah != null) {
                      await ref
                          .read(playerProvider.notifier)
                          .play(surahID: surah.id);
                    }
                  }
                },
              );
            }).toList();
          },
          loading: () => [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            ),
          ],
          error: (err, stack) => [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: Text('حدث خطأ في تحميل السجل')),
            ),
          ],
        );
      },
    );
  }
}

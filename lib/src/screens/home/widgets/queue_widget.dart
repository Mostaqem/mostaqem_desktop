import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/reading/reading_screen.dart';
import 'package:mostaqem/src/shared/widgets/text_hover.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';

class QueueWidget extends ConsumerWidget {
  const QueueWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queue = ref.watch(playerNotifierProvider).queue;
    final playingSurah = ref.watch(playerNotifierProvider).queueIndex;
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تسمع التالي',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ReorderableListView.builder(
                  itemCount: queue.length,
                  buildDefaultDragHandles: false,
                  cacheExtent: 100,
                  header: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  onReorder: (oldIndex, newIndex) async {
                    await ref
                        .read(playerNotifierProvider.notifier)
                        .moveItem(oldIndex, newIndex);
                  },

                  itemBuilder: (context, index) {
                    final isSurahPlaying = index == playingSurah;

                    return ListTile(
                      key: ValueKey('$index-${queue[index].hashCode}'),

                      onTap: () {
                        ref
                            .read(playerNotifierProvider.notifier)
                            .playItem(index);
                      },
                      leading: Row(
                        spacing: 10,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Tooltip(
                            message: context.tr.move_item,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.grab,
                              child: ReorderableDragStartListener(
                                index: index,
                                child: Icon(
                                  Icons.drag_handle,
                                  color: isSurahPlaying
                                      ? Theme.of(context).colorScheme.primary
                                      : null,
                                ),
                              ),
                            ),
                          ),

                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 13,
                                child: Text(
                                  (index + 1).toString().toArabicNumbers,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      contentPadding: EdgeInsets.zero,
                      selected: isSurahPlaying,
                      title: Text(
                        queue[index].surah.arabicName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(queue[index].reciter.arabicName),
                      trailing: ToolTipIconButton(
                        message: context.tr.remove_from_queue,
                        onPressed: () {
                          ref
                              .read(playerNotifierProvider.notifier)
                              .removeItem(index);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: isSurahPlaying
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

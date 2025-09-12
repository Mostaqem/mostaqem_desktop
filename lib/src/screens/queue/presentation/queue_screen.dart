import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/reading/reading_screen.dart';
import 'package:mostaqem/src/shared/widgets/back_button.dart';
import 'package:mostaqem/src/shared/widgets/window_buttons.dart';

class QueueScreen extends StatelessWidget {
  const QueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 100, top: 100),
            child: Consumer(
              builder: (context, ref, child) {
                final queue = ref.watch(playerNotifierProvider).queue;
                final playingSurah = ref
                    .watch(playerNotifierProvider)
                    .queueIndex;
                final locale = ref.watch(localeNotifierProvider).languageCode;
                return ReorderableListView.builder(
                  itemCount: queue.length,
                  buildDefaultDragHandles: false,
                  cacheExtent: 100,
                  header: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Text(
                      context.tr.play_next_item,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondaryContainer,
                      ),
                    ),
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

                      tileColor: isSurahPlaying
                          ? Theme.of(context).colorScheme.secondary
                          : null,
                      textColor: isSurahPlaying
                          ? Theme.of(context).colorScheme.onSecondary
                          : null,
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
                                      ? Theme.of(
                                          context,
                                        ).colorScheme.onSecondary
                                      : null,
                                ),
                              ),
                            ),
                          ),

                          Stack(
                            children: [
                              if (queue[index].surah.image != null)
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        queue[index].surah.image!,
                                      ),
                                    ),
                                  ),
                                )
                              else
                                const SizedBox.shrink(),
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
                      title: Text(
                        locale == 'ar'
                            ? queue[index].surah.arabicName
                            : queue[index].surah.simpleName,
                      ),
                      subtitle: Text(
                        locale == 'ar'
                            ? queue[index].reciter.arabicName
                            : queue[index].reciter.englishName,
                      ),
                      trailing: PopupMenuButton(
                        iconColor: isSurahPlaying
                            ? Theme.of(context).colorScheme.onSecondary
                            : null,

                        itemBuilder: (context) => [
                          PopupMenuItem<String>(
                            child: Row(
                              spacing: 10,
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  color: isSurahPlaying
                                      ? Theme.of(
                                          context,
                                        ).colorScheme.onSecondary
                                      : null,
                                ),
                                const Text('تشغيل السورة'),
                              ],
                            ),
                            onTap: () {
                              ref
                                  .read(playerNotifierProvider.notifier)
                                  .playItem(index);
                            },
                          ),
                          PopupMenuItem<String>(
                            child: Row(
                              spacing: 10,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: isSurahPlaying
                                      ? Theme.of(
                                          context,
                                        ).colorScheme.onSecondary
                                      : null,
                                ),
                                const Text('حذف السورة من قائمة التشغيل'),
                              ],
                            ),
                            onTap: () {
                              ref
                                  .read(playerNotifierProvider.notifier)
                                  .removeItem(index);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            color: Theme.of(context).colorScheme.surface,
            height: 100,
            child: const Column(
              children: [
                WindowButtons(),
                SizedBox(height: 10),
                Align(alignment: Alignment.topLeft, child: AppBackButton()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

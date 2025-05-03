import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/navigation/repository/download_repository.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';
import 'package:mostaqem/src/screens/reciters/providers/search_notifier.dart';
import 'package:mostaqem/src/shared/widgets/hover_builder.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';
import 'package:vector_graphics/vector_graphics.dart';

final reciterProvider = StateProvider<Reciter?>((ref) {
  return null;
});

class SurahWidget extends ConsumerWidget {
  const SurahWidget({super.key});
  static const pageSize = 30;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchNotifierProvider('home'));
    final surahID = ref.watch(currentSurahProvider)?.id ?? 0;
    final downlaodState = ref.watch(downloadAudioProvider)?.downloadState;
    return SizedBox(
      height: MediaQuery.sizeOf(context).height - 255,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 160,
        ),
        itemBuilder: (context, index) {
          final page = index ~/ pageSize + 1;
          final indexInPage = index % pageSize;

          final surahs = ref.watch(
            fetchAllChaptersProvider(page: page, query: searchQuery),
          );

          return surahs.when(
            data: (data) {
              if (indexInPage >= data.length) {
                return null;
              }
              return ContextMenuRegion(
                contextMenu: GenericContextMenu(
                  buttonConfigs: [
                    ContextMenuButtonConfig(
                      'تشغيل التالي',
                      onPressed: () async {
                        await ref
                            .read(playerNotifierProvider.notifier)
                            .addItemNext(data[indexInPage].id);
                      },
                    ),
                    ContextMenuButtonConfig(
                      'اضافة في القائمة التشغيل',
                      onPressed: () async {
                        await ref
                            .read(playerNotifierProvider.notifier)
                            .addToQueue(surahID: data[indexInPage].id);
                      },
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: HoverBuilder(
                    builder: (isHovered) {
                      return InkWell(
                        onTap: () async {
                          await ref
                              .read(playerNotifierProvider.notifier)
                              .play(surahID: data[indexInPage].id);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                            decoration: BoxDecoration(
                              color:
                                  downlaodState == DownloadState.downloading &&
                                          surahID - 1 == index
                                      ? Theme.of(
                                        context,
                                      ).colorScheme.tertiaryContainer
                                      : isHovered
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(
                                        context,
                                      ).colorScheme.primaryContainer,
                            ),
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Positioned(
                                  left: -70,
                                  child: VectorGraphic(
                                    loader: const AssetBytesLoader(
                                      'assets/img/svg/shape.svg',
                                    ),
                                    width: 130,
                                    colorFilter: ColorFilter.mode(
                                      isHovered
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onPrimary
                                              .withValues(alpha: 0.1)
                                          : Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer
                                              .withValues(alpha: 0.1),
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            data[indexInPage].arabicName,
                                            style: TextStyle(
                                              color:
                                                  isHovered
                                                      ? Theme.of(
                                                        context,
                                                      ).colorScheme.onPrimary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .onPrimaryContainer,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            data[indexInPage].simpleName,
                                            style: TextStyle(
                                              color:
                                                  isHovered
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary
                                                          .withValues(
                                                            alpha: 0.5,
                                                          )
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .onPrimaryContainer
                                                          .withValues(
                                                            alpha: 0.5,
                                                          ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  left: 0,
                                  child: PopupMenuButton(
                                    iconColor:
                                        isHovered
                                            ? Theme.of(
                                              context,
                                            ).colorScheme.onPrimary
                                            : null,

                                    itemBuilder:
                                        (context) => [
                                          PopupMenuItem<String>(
                                            child: const Text('اضافة التالي'),
                                            onTap: () {
                                              ref
                                                  .read(
                                                    playerNotifierProvider
                                                        .notifier,
                                                  )
                                                  .addItemNext(
                                                    data[indexInPage].id,
                                                  );
                                            },
                                          ),
                                          PopupMenuItem<String>(
                                            child: const Text(
                                              'اضافة في قائمة التشغيل',
                                            ),
                                            onTap: () {
                                              ref
                                                  .read(
                                                    playerNotifierProvider
                                                        .notifier,
                                                  )
                                                  .addToQueue(
                                                    surahID:
                                                        data[indexInPage].id,
                                                  );
                                            },
                                          ),
                                        ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            error: (e, __) {
              debugPrint('Error: $e');
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withValues(alpha: 0.3),
                  ),
                  child: ToolTipIconButton(
                    message: 'اعادة المحاولة',
                    onPressed: () {
                      ref.invalidate(fetchAllChaptersProvider);
                    },
                    icon: const Icon(Icons.refresh_outlined),
                  ),
                ),
              );
            },
            loading: () {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withValues(alpha: 0.3),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

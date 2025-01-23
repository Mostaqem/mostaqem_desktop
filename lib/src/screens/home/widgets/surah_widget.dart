import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/navigation/repository/download_repository.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';
import 'package:mostaqem/src/screens/reciters/providers/search_notifier.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';

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

          final surahs = ref
              .watch(fetchAllChaptersProvider(page: page, query: searchQuery));

          return surahs.when(
            data: (data) {
              if (indexInPage >= data.length) {
                return null;
              }
              return Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    decoration: BoxDecoration(
                      color: downlaodState == DownloadState.downloading &&
                              surahID - 1 == index
                          ? Theme.of(context).colorScheme.tertiaryContainer
                          : Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Positioned(
                          left: -70,
                          child: SvgPicture.asset(
                            'assets/img/shape.svg',
                            width: 130,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context)
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    data[indexInPage].arabicName,
                                    style: TextStyle(
                                      color: Theme.of(context)
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer
                                          .withValues(alpha: 0.5),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Consumer(
                                    builder: (context, ref, child) {
                                      return Tooltip(
                                        message: 'تشغيل',
                                        preferBelow: false,
                                        child: IconButton(
                                          onPressed: () async {
                                            await ref
                                                .read(
                                                  playerNotifierProvider
                                                      .notifier,
                                                )
                                                .play(
                                                  surahID: data[indexInPage].id,
                                                );
                                          },
                                          icon: const Icon(
                                            Icons.play_circle_fill_outlined,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
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
            error: (e, __) {
              debugPrint('Error: $e');
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withValues(alpha: 0.3),
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
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withValues(alpha: 0.3),
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

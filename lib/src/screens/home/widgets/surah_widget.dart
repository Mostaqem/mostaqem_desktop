import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/navigation/repository/download_repository.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player_widget.dart';
import 'package:mostaqem/src/screens/offline/repository/offline_repository.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';

final reciterProvider = StateProvider<Reciter?>((ref) {
  final isLocalAudio = ref.read(playerNotifierProvider.notifier).isLocalAudio();
  if (isLocalAudio) {
    final currentPlayer = ref.watch(playerSurahProvider);
    final audios = ref.read(getLocalAudioProvider).value!;
    final currentIndex = audios.indexWhere((e) => e == currentPlayer);
    return audios[currentIndex].reciter;
  }
  return null;
});

class SurahWidget extends ConsumerWidget {
  const SurahWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surahs = ref.watch(filterSurahByQueryProvider);
    final player = ref.watch(playerSurahProvider)?.surah.id ?? 0;
    final downlaodState = ref.watch(downloadAudioProvider)?.downloadState;
    return AsyncWidget(
      value: surahs,
      data: (data) => SizedBox(
        height: MediaQuery.sizeOf(context).height - 285,
        child: GridView.builder(
          itemCount: data.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 160,
          ),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
                decoration: BoxDecoration(
                  color: downlaodState == DownloadState.downloading &&
                          player - 1 == index
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
                              .withOpacity(0.1),
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
                                data[index].arabicName,
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
                                data[index].simpleName,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer
                                      .withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
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
                                              playerNotifierProvider.notifier,
                                            )
                                            .play(
                                              surahID: data[index].id,
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
          ),
        ),
      ),
    );
  }
}

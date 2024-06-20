import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/home/widgets/surah_widget.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/shared/widgets/hover_builder.dart';

import '../../../core/routes/routes.dart';
import '../../home/providers/home_providers.dart';
import 'volume_control.dart';

final playerSurahProvider = StateProvider((ref) => (
      name: "الفاتحة",
      reciter: "عبدالباسط",
      english: "Al-Fatiha",
      url: "https://download.quranicaudio.com/qdc/abdul_baset/mujawwad/1.mp3"
    ));

class PlayerWidget extends ConsumerWidget {
  const PlayerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            color: Theme.of(context).colorScheme.secondaryContainer),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Consumer(builder: (context, ref, child) {
                      final surah = ref.watch(playerSurahProvider);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            surah.name,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer),
                          ),
                          HoverBuilder(builder: (isHovered) {
                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  ref
                                      .read(goRouterProvider)
                                      .push('/reciters');
                                },
                                child: Text(
                                  surah.reciter,
                                  style: TextStyle(
                                      decoration: isHovered
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                      color: isHovered
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onSecondaryContainer
                                          : Theme.of(context)
                                              .colorScheme
                                              .onSecondaryContainer
                                              .withOpacity(0.5)),
                                ),
                              ),
                            );
                          }),
                        ],
                      );
                    }),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: ref
                                .watch(playerNotifierProvider.notifier)
                                .isFirstChapter(),
                            child: Tooltip(
                              message: "قبل",
                              preferBelow: false,
                              child: IconButton(
                                onPressed: () async {
                                  final surahID =
                                      ref.read(surahIDProvider) - 1;
                                  await ref.read(seekIDProvider(
                                          surahID: surahID,
                                          reciter: ref.read(reciterProvider))
                                      .future);
                                },
                                icon: const Icon(Icons.skip_next_outlined),
                                iconSize: 25,
                              ),
                            ),
                          ),
                          Tooltip(
                            message: "تشغيل",
                            preferBelow: false,
                            child: IconButton(
                              onPressed: () => ref
                                  .read(playerNotifierProvider.notifier)
                                  .handlePlayPause(),
                              icon: ref.read(playerNotifierProvider).isPlaying
                                  ? const Icon(
                                      Icons.pause_circle_filled_outlined)
                                  : const Icon(
                                      Icons.play_circle_fill_outlined),
                              iconSize: 25,
                            ),
                          ),
                          Visibility(
                            visible: ref
                                .watch(playerNotifierProvider.notifier)
                                .isLastchapter(),
                            child: Tooltip(
                              message: "بعد",
                              preferBelow: false,
                              child: IconButton(
                                onPressed: () async {
                                  final surahID =
                                      ref.read(surahIDProvider) + 1;
                                  await ref.read(seekIDProvider(
                                          surahID: surahID,
                                          reciter: ref.read(reciterProvider))
                                      .future);
                                },
                                icon:
                                    const Icon(Icons.skip_previous_outlined),
                                iconSize: 25,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(ref
                              .watch(playerNotifierProvider.notifier)
                              .playerTime()
                              .$1),
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                                maxWidth: 500, maxHeight: 10),
                            child: HoverBuilder(builder: (isHovered) {
                              return SliderTheme(
                                data: SliderThemeData(
                                    thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: isHovered ? 7 : 3,
                                  elevation: 0,
                                )),
                                child: Slider(
                                    value: ref
                                        .watch(playerNotifierProvider)
                                        .position
                                        .inSeconds
                                        .toDouble(),
                                    min: 0.0,
                                    max: ref
                                        .watch(playerNotifierProvider)
                                        .duration
                                        .inSeconds
                                        .toDouble(),
                                    onChanged: (v) => ref
                                        .watch(
                                            playerNotifierProvider.notifier)
                                        .handleSeek(v)),
                              );
                            }),
                          ),
                          Text(ref
                              .watch(playerNotifierProvider.notifier)
                              .playerTime()
                              .$2),
                        ],
                      ),
                    ],
                  ),
                ),
                const VolumeControls(),
              ]),
        ));
  }
}

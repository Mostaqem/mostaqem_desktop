// ignore_for_file: strict_raw_type, inference_failure_on_instance_creation

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:mostaqem/src/screens/fullscreen/widgets/full_screen_controls.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/volume_control.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/navigation/widgets/squiggly/squiggly_slider.dart';
import 'package:mostaqem/src/screens/settings/appearance/providers/squiggly_notifier.dart';
import 'package:mostaqem/src/shared/widgets/hover_builder.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';

class FullScreenPlayControls extends ConsumerWidget {
  const FullScreenPlayControls({super.key});

  Icon loopIcon(PlaylistMode state, Color color) {
    if (state == PlaylistMode.none) {
      return Icon(
        Icons.repeat,
        size: 16,
        color: color,
      );
    }
    if (state == PlaylistMode.single) {
      return Icon(
        Icons.repeat,
        size: 16,
        color: color,
      );
    }
    return Icon(
      Icons.repeat_one_outlined,
      size: 16,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerNotifierProvider);
    final isSquiggly = ref.watch(squigglyNotifierProvider);

    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ref.watch(playerNotifierProvider.notifier).playerTime().$1,
                  style: const TextStyle(color: Colors.white),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width / 1.5,
                    maxHeight: 10,
                  ),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final position = player.position.inSeconds.toDouble();
                      final duration = player.duration.inSeconds.toDouble();
                      return HoverBuilder(
                        builder: (isHovered) {
                          return SliderTheme(
                            data: SliderThemeData(
                              thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: isHovered ? 7 : 3,
                                elevation: 0,
                              ),
                            ),
                            child: isSquiggly
                                ? SquigglySlider(
                                    squiggleAmplitude: 3,
                                    squiggleWavelength: 5,
                                    squiggleSpeed: 0.2,
                                    activeColor: Colors.white,
                                    value: max(0, min(position, duration)),
                                    max: duration,
                                    onChangeStart: (_) async {
                                      final isPlaying = player.isPlaying;
                                      if (isPlaying) {
                                        await ref
                                            .read(
                                              playerNotifierProvider.notifier,
                                            )
                                            .player
                                            .pause();
                                      }
                                    },
                                    onChangeEnd: (value) async {
                                      await ref
                                          .read(playerNotifierProvider.notifier)
                                          .handleSeek(
                                            Duration(seconds: value.toInt()),
                                          );
                                      await ref
                                          .read(playerNotifierProvider.notifier)
                                          .player
                                          .play();
                                    },
                                    onChanged: (value) {
                                      ref
                                          .read(playerNotifierProvider.notifier)
                                          .changePosition(
                                            Duration(seconds: value.toInt()),
                                          );
                                    },
                                  )
                                : Slider(
                                    activeColor: Colors.white,
                                    value: max(0, min(position, duration)),
                                    max: duration,
                                    onChangeStart: (_) async {
                                      final isPlaying = ref
                                          .read(playerNotifierProvider)
                                          .isPlaying;
                                      if (isPlaying) {
                                        await ref
                                            .read(
                                              playerNotifierProvider.notifier,
                                            )
                                            .player
                                            .pause();
                                      }
                                    },
                                    onChangeEnd: (value) async {
                                      await ref
                                          .read(playerNotifierProvider.notifier)
                                          .handleSeek(
                                            Duration(seconds: value.toInt()),
                                          );
                                      await ref
                                          .read(playerNotifierProvider.notifier)
                                          .player
                                          .play();
                                    },
                                    onChanged: (value) {
                                      ref
                                          .read(playerNotifierProvider.notifier)
                                          .changePosition(
                                            Duration(seconds: value.toInt()),
                                          );
                                    },
                                  ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Text(
                  ref.watch(playerNotifierProvider.notifier).playerTime().$2,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            Transform.scale(
              scale: 1.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: ref
                            .watch(playerNotifierProvider.notifier)
                            .isFirstChapter() &&
                        ref.watch(playerSurahProvider) != null,
                    child: Tooltip(
                      message: 'قبل',
                      preferBelow: false,
                      child: IconButton(
                        onPressed: () async {
                          await ref
                              .read(playerNotifierProvider.notifier)
                              .playPrevious();
                        },
                        icon: const Icon(
                          Icons.skip_next_outlined,
                          color: Colors.white,
                        ),
                        iconSize: 25,
                      ),
                    ),
                  ),
                  Tooltip(
                    message: 'تشغيل',
                    preferBelow: false,
                    child: IconButton(
                      onPressed: () async {
                        await ref
                            .read(playerNotifierProvider.notifier)
                            .handlePlayPause();
                      },
                      icon: player.isPlaying
                          ? const Icon(
                              Icons.pause_circle_filled_outlined,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.play_circle_fill_outlined,
                              color: Colors.white,
                            ),
                      iconSize: 25,
                    ),
                  ),
                  Visibility(
                    visible: ref
                            .watch(playerNotifierProvider.notifier)
                            .isLastchapter() &&
                        ref.watch(playerSurahProvider) != null,
                    child: Tooltip(
                      message: 'بعد',
                      preferBelow: false,
                      child: IconButton(
                        onPressed: () async {
                          await ref
                              .read(playerNotifierProvider.notifier)
                              .playNext();
                        },
                        icon: const Icon(
                          Icons.skip_previous_outlined,
                          color: Colors.white,
                        ),
                        iconSize: 25,
                      ),
                    ),
                  ),
                  Tooltip(
                    message: 'اعادة',
                    preferBelow: false,
                    child: IconButton(
                      onPressed: () async {
                        ref.read(playerNotifierProvider.notifier).loop();
                      },
                      icon: loopIcon(
                        player.loop,
                        player.loop == PlaylistMode.none
                            ? Colors.white
                            : Theme.of(context).colorScheme.tertiary,
                      ),
                      iconSize: 16,
                    ),
                  ),
                  const FullScreenControl(isFullScreen: true),
                  ToolTipIconButton(
                    message: 'كلام',
                    onPressed: () {},
                    icon: const Icon(Icons.lyrics_outlined),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Expanded(child: VolumeControls()),
      ],
    );
  }
}

// ignore_for_file: strict_raw_type, inference_failure_on_instance_creation,
// ignore_for_file: invalid_use_of_protected_member,
// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';
import 'package:mostaqem/src/screens/fullscreen/providers/lyrics_notifier.dart';
import 'package:mostaqem/src/screens/fullscreen/widgets/full_screen_controls.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/volume_control.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/navigation/widgets/squiggly/squiggly_slider.dart';
import 'package:mostaqem/src/screens/settings/appearance/providers/squiggly_notifier.dart';
import 'package:mostaqem/src/shared/widgets/hover_builder.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';
import 'package:vector_graphics/vector_graphics.dart';

class FullScreenPlayControls extends ConsumerWidget {
  const FullScreenPlayControls({super.key});

  Icon loopIcon(PlaylistMode state, Color color) {
    if (state == PlaylistMode.none) {
      return Icon(Icons.repeat, size: 16, color: color);
    }
    if (state == PlaylistMode.single) {
      return Icon(Icons.repeat, size: 16, color: color);
    }
    return Icon(Icons.repeat_one_outlined, size: 16, color: color);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerNotifierProvider);
    final isSquiggly = ref.watch(squigglyNotifierProvider);
    final lyricsState = ref.watch(lyricsNotifierProvider);
    final imageColor = ref.watch(getImageColorProvider);
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ref
                      .watch(playerNotifierProvider.notifier)
                      .playerTime()
                      .currentTime,
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
                                    useLineThumb: true,
                                    activeColor:
                                        imageColor.asData?.value ??
                                        Theme.of(context).colorScheme.primary,
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
                                    inactiveColor: Colors.white.withValues(
                                      alpha: 0.1,
                                    ),
                                    value: max(0, min(position, duration)),
                                    max: duration,
                                    activeColor:
                                        imageColor.asData?.value ??
                                        Theme.of(context).colorScheme.primary,
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
                  ref
                      .watch(playerNotifierProvider.notifier)
                      .playerTime()
                      .durationTime,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            Transform.scale(
              scale: 1.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToolTipIconButton(
                    message: context.tr.shuffle,
                    onPressed: () async {
                      await ref.read(playerNotifierProvider.notifier).shuffle();
                    },
                    icon: Icon(
                      Icons.shuffle,
                      color: player.isShuffle
                          ? Theme.of(context).colorScheme.tertiary
                          : Colors.white,
                    ),
                    iconSize: 16,
                  ),
                  Visibility(
                    visible: !ref
                        .watch(playerNotifierProvider.notifier)
                        .isFirstChapter(),
                    child: Tooltip(
                      message: context.tr.previous,
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
                    message: context.tr.next,
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
                    visible: !ref
                        .watch(playerNotifierProvider.notifier)
                        .isLastchapter(),
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
                    message: context.tr.repeat,
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
                  Visibility(
                    visible: !ref.watch(isLocalProvider),
                    child: ToolTipIconButton(
                      iconSize: 16,
                      message: context.tr.lyrics,
                      onPressed: () {
                        final canPop = ref
                            .read(navigationProvider)
                            .canPop(expectedPath: '/reading');
                        if (canPop) {
                          ref.read(goRouterProvider).pop();
                        }
                        if (lyricsState == true) {
                          ref.read(lyricsNotifierProvider.notifier).state =
                              false;
                        } else {
                          ref.read(lyricsNotifierProvider.notifier).state =
                              true;
                        }
                      },
                      icon: Icon(
                        Icons.lyrics_outlined,
                        color: lyricsState
                            ? Theme.of(context).colorScheme.tertiary
                            : Colors.white,
                      ),
                    ),
                  ),
                  ToolTipIconButton(
                    message: context.tr.read,
                    onPressed: () async {
                      final surah = ref.read(currentSurahProvider);
                      final canPop = ref
                          .read(navigationProvider)
                          .canPop(expectedPath: '/reading');
                      if (canPop) {
                        ref.read(goRouterProvider).pop();
                        return;
                      }

                      ref
                          .read(goRouterProvider)
                          .goNamed('Reading', extra: surah);
                    },
                    icon: const VectorGraphic(
                      loader: AssetBytesLoader('assets/img/svg/read.svg'),
                      width: 16,
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const FullScreenControl(isFullScreen: true),
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

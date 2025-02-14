// ignore_for_file: strict_raw_type, inference_failure_on_instance_creation

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/squiggly/squiggly_slider.dart';
import 'package:mostaqem/src/screens/settings/appearance/providers/squiggly_notifier.dart';
import 'package:mostaqem/src/shared/widgets/hover_builder.dart';

class PlayControls extends ConsumerWidget {
  const PlayControls({required this.isFullScreen, super.key});
  final bool isFullScreen;

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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Transform.scale(
        scale: isFullScreen ? 1.3 : 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible:
                      ref
                          .watch(playerNotifierProvider.notifier)
                          .isFirstChapter(),
                  child: Tooltip(
                    message: 'قبل',
                    preferBelow: false,
                    child: IconButton(
                      onPressed: () async {
                        await ref
                            .read(playerNotifierProvider.notifier)
                            .playPrevious();
                      },
                      icon: Icon(
                        Icons.skip_next_outlined,
                        color:
                            isFullScreen
                                ? Colors.white
                                : Theme.of(
                                  context,
                                ).colorScheme.onSecondaryContainer,
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
                    icon:
                        player.isPlaying
                            ? Icon(
                              Icons.pause_circle_filled_outlined,
                              color:
                                  isFullScreen
                                      ? Colors.white
                                      : Theme.of(
                                        context,
                                      ).colorScheme.onSecondaryContainer,
                            )
                            : Icon(
                              Icons.play_circle_fill_outlined,
                              color:
                                  isFullScreen
                                      ? Colors.white
                                      : Theme.of(
                                        context,
                                      ).colorScheme.onSecondaryContainer,
                            ),
                    iconSize: 25,
                  ),
                ),
                Visibility(
                  visible:
                      ref
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
                      icon: Icon(
                        Icons.skip_previous_outlined,
                        color:
                            isFullScreen
                                ? Colors.white
                                : Theme.of(
                                  context,
                                ).colorScheme.onSecondaryContainer,
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
                          ? isFullScreen
                              ? Colors.white
                              : Theme.of(
                                context,
                              ).colorScheme.onSecondaryContainer
                          : Theme.of(context).colorScheme.tertiary,
                    ),
                    iconSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ref
                      .watch(playerNotifierProvider.notifier)
                      .playerTime()
                      .currentTime,
                  style: TextStyle(color: isFullScreen ? Colors.white : null),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth:
                        isFullScreen
                            ? MediaQuery.sizeOf(context).width / 1.5
                            : MediaQuery.sizeOf(context).width / 2.5,
                    maxHeight: 10,
                  ),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final position = player.position.inSeconds.toDouble();
                      final duration = player.duration.inSeconds.toDouble();
                      return Stack(
                        children: [
                          Visibility(
                            visible: false,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 4,
                                left: 25,
                                right: 25,
                              ),
                              child: LinearProgressIndicator(
                                value: player.buffering.inSeconds.toDouble(),
                                borderRadius: BorderRadius.circular(12),
                                valueColor: AlwaysStoppedAnimation(
                                  Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(alpha: 0.2),
                                ),
                              ),
                            ),
                          ),
                          HoverBuilder(
                            builder: (isHovered) {
                              return SliderTheme(
                                data: SliderThemeData(
                                  thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: isHovered ? 7 : 3,
                                    elevation: 0,
                                  ),
                                ),
                                child:
                                    isSquiggly
                                        ? SquigglyPlayerSlider(
                                          position: position,
                                          duration: duration,
                                        )
                                        : NormalPlayerSlider(
                                          position: position,
                                          duration: duration,
                                        ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Text(
                  ref
                      .watch(playerNotifierProvider.notifier)
                      .playerTime()
                      .durationTime,
                  style: TextStyle(color: isFullScreen ? Colors.white : null),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NormalPlayerSlider extends ConsumerWidget {
  const NormalPlayerSlider({
    required this.position,
    required this.duration,
    super.key,
  });

  final double position;
  final double duration;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slider(
      value: max(0, min(position, duration)),
      max: duration,
      onChangeStart: (_) async {
        final isPlaying = ref.read(playerNotifierProvider).isPlaying;
        if (isPlaying) {
          await ref.read(playerNotifierProvider.notifier).player.pause();
        }
      },
      onChangeEnd: (value) async {
        await ref
            .read(playerNotifierProvider.notifier)
            .handleSeek(Duration(seconds: value.toInt()));
        await ref.read(playerNotifierProvider.notifier).player.play();
      },
      onChanged: (value) {
        ref
            .read(playerNotifierProvider.notifier)
            .changePosition(Duration(seconds: value.toInt()));
      },
    );
  }
}

class SquigglyPlayerSlider extends ConsumerWidget {
  const SquigglyPlayerSlider({
    required this.position,
    required this.duration,
    super.key,
  });

  final double position;
  final double duration;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SquigglySlider(
      squiggleAmplitude: 3,
      squiggleWavelength: 5,
      squiggleSpeed: 0.2,
      value: max(0, min(position, duration)),
      max: duration,
      onChangeStart: (_) async {
        final isPlaying = ref.read(playerNotifierProvider).isPlaying;
        if (isPlaying) {
          await ref.read(playerNotifierProvider.notifier).player.pause();
        }
      },
      onChangeEnd: (value) async {
        await ref
            .read(playerNotifierProvider.notifier)
            .handleSeek(Duration(seconds: value.toInt()));
        await ref.read(playerNotifierProvider.notifier).player.play();
      },
      onChanged: (value) {
        ref
            .read(playerNotifierProvider.notifier)
            .changePosition(Duration(seconds: value.toInt()));
      },
    );
  }
}

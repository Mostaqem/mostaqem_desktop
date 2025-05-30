// ignore_for_file: strict_raw_type, inference_failure_on_instance_creation,
// ignore_for_file: invalid_use_of_protected_member,
// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/fullscreen/widgets/full_screen_controls.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/volume_control.dart';
import 'package:mostaqem/src/screens/navigation/widgets/squiggly/squiggly_slider.dart';
import 'package:mostaqem/src/screens/settings/appearance/providers/squiggly_notifier.dart';
import 'package:mostaqem/src/shared/widgets/hover_builder.dart';

class BroadcastFullscreenControls extends ConsumerWidget {
  const BroadcastFullscreenControls({super.key});


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
                            child:
                                isSquiggly
                                    ? SquigglySlider(
                                      squiggleAmplitude: 3,
                                      squiggleWavelength: 5,
                                      squiggleSpeed: 0.2,
                                      useLineThumb: true,
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
                                            .read(
                                              playerNotifierProvider.notifier,
                                            )
                                            .handleSeek(
                                              Duration(seconds: value.toInt()),
                                            );
                                        await ref
                                            .read(
                                              playerNotifierProvider.notifier,
                                            )
                                            .player
                                            .play();
                                      },
                                      onChanged: (value) {
                                        ref
                                            .read(
                                              playerNotifierProvider.notifier,
                                            )
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
                                        final isPlaying =
                                            ref
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
                                            .read(
                                              playerNotifierProvider.notifier,
                                            )
                                            .handleSeek(
                                              Duration(seconds: value.toInt()),
                                            );
                                        await ref
                                            .read(
                                              playerNotifierProvider.notifier,
                                            )
                                            .player
                                            .play();
                                      },
                                      onChanged: (value) {
                                        ref
                                            .read(
                                              playerNotifierProvider.notifier,
                                            )
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/full_screen_controls.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/player_widget.dart';
import 'package:mostaqem/src/shared/widgets/hover_builder.dart';

import 'package:mostaqem/src/screens/navigation/widgets/player/volume_control.dart';

class PlayControls extends StatelessWidget {
  const PlayControls({
    required this.isFullScreen,
    required this.ref,
    super.key,
  });
  final bool isFullScreen;
  final WidgetRef ref;

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
  Widget build(BuildContext context) {
    final player = ref.watch(playerNotifierProvider);
    // TODO(mezoPeeta): Refactor playcontrols
    return Transform.scale(
      scale: isFullScreen ? 1.3 : 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible:
                    ref.watch(playerNotifierProvider.notifier).isFirstChapter(),
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
                      color: isFullScreen
                          ? Colors.white
                          : Theme.of(context).colorScheme.onSecondaryContainer,
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
                      ? Icon(
                          Icons.pause_circle_filled_outlined,
                          color: isFullScreen
                              ? Colors.white
                              : Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                        )
                      : Icon(
                          Icons.play_circle_fill_outlined,
                          color: isFullScreen
                              ? Colors.white
                              : Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
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
                    icon: Icon(
                      Icons.skip_previous_outlined,
                      color: isFullScreen
                          ? Colors.white
                          : Theme.of(context).colorScheme.onSecondaryContainer,
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
                            : Theme.of(context).colorScheme.onSecondaryContainer
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
                ref.watch(playerNotifierProvider.notifier).playerTime().$1,
                style: TextStyle(color: isFullScreen ? Colors.white : null),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isFullScreen
                      ? MediaQuery.sizeOf(context).width / 1.5
                      : MediaQuery.sizeOf(context).width / 2.5,
                  maxHeight: 10,
                ),
                child: HoverBuilder(
                  builder: (isHovered) {
                    return SliderTheme(
                      data: SliderThemeData(
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: isHovered ? 7 : 3,
                          elevation: 0,
                        ),
                      ),
                      child: Slider(
                        value: ref
                            .watch(playerNotifierProvider)
                            .position
                            .inSeconds
                            .toDouble(),
                        max: ref
                            .watch(playerNotifierProvider)
                            .duration
                            .inSeconds
                            .toDouble(),
                        onChanged: (v) => ref
                            .watch(playerNotifierProvider.notifier)
                            .handleSeek(Duration(seconds: v.toInt())),
                      ),
                    );
                  },
                ),
              ),
              Text(
                ref.watch(playerNotifierProvider.notifier).playerTime().$2,
                style: TextStyle(color: isFullScreen ? Colors.white : null),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FullScreenPlayControls extends StatefulWidget {
  const FullScreenPlayControls({required this.ref, super.key});
  final WidgetRef ref;

  @override
  State<FullScreenPlayControls> createState() => _FullScreenPlayControlsState();
}

class _FullScreenPlayControlsState extends State<FullScreenPlayControls> {
  Timer? _timer;
  bool _isVisible = true;

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

  void _resetTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }

    _timer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _isVisible = false;
      });
    });

    setState(() {
      _isVisible = true;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final player = widget.ref.watch(playerNotifierProvider);

    return Visibility(
      visible: _isVisible,
      child: MouseRegion(
        onHover: (event) {
          _resetTimer();
        },
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.ref
                          .watch(playerNotifierProvider.notifier)
                          .playerTime()
                          .$1,
                      style: const TextStyle(color: Colors.white),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.sizeOf(context).width / 1.5,
                        maxHeight: 10,
                      ),
                      child: HoverBuilder(
                        builder: (isHovered) {
                          return SliderTheme(
                            data: SliderThemeData(
                              thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: isHovered ? 7 : 3,
                                elevation: 0,
                              ),
                            ),
                            child: Slider(
                              activeColor: Colors.white,
                              value: widget.ref
                                  .watch(playerNotifierProvider)
                                  .position
                                  .inSeconds
                                  .toDouble(),
                              max: widget.ref
                                  .watch(playerNotifierProvider)
                                  .duration
                                  .inSeconds
                                  .toDouble(),
                              onChanged: (v) => widget.ref
                                  .watch(playerNotifierProvider.notifier)
                                  .handleSeek(Duration(seconds: v.toInt())),
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      widget.ref
                          .watch(playerNotifierProvider.notifier)
                          .playerTime()
                          .$2,
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
                        visible: widget.ref
                                .watch(playerNotifierProvider.notifier)
                                .isFirstChapter() &&
                            widget.ref.watch(playerSurahProvider) != null,
                        child: Tooltip(
                          message: 'قبل',
                          preferBelow: false,
                          child: IconButton(
                            onPressed: () async {
                              await widget.ref
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
                            await widget.ref
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
                        visible: widget.ref
                                .watch(playerNotifierProvider.notifier)
                                .isLastchapter() &&
                            widget.ref.watch(playerSurahProvider) != null,
                        child: Tooltip(
                          message: 'بعد',
                          preferBelow: false,
                          child: IconButton(
                            onPressed: () async {
                              await widget.ref
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
                            widget.ref
                                .read(playerNotifierProvider.notifier)
                                .loop();
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
                      FullScreenControl(ref: widget.ref, isFullScreen: true),
                    ],
                  ),
                ),
              ],
            ),
            const Expanded(child: VolumeControls()),
          ],
        ),
      ),
    );
  }
}

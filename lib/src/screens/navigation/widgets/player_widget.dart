import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mostaqem/src/screens/home/widgets/surah_widget.dart';
import 'package:mostaqem/src/shared/widgets/hover_builder.dart';
import 'package:windows_taskbar/windows_taskbar.dart';

import '../../../core/routes/routes.dart';
import '../../home/providers/home_providers.dart';
import 'volume_control.dart';

final playerSurahProvider = StateProvider((ref) => (
      name: "الفاتحة",
      reciter: "عبدالباسط",
      url: "https://download.quranicaudio.com/qdc/abdul_baset/mujawwad/1.mp3"
    ));

class PlayerWidget extends ConsumerStatefulWidget {
  const PlayerWidget({
    super.key,
  });

  @override
  ConsumerState<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends ConsumerState<PlayerWidget> {
  bool isPlaying = false;

  final player = AudioPlayer();

  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  @override
  void initState() {
    super.initState();
    player.setUrl(ref.read(playerSurahProvider).url, preload: true);

    player.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.ready) {
        if (Platform.isWindows) {
          windowThumbnailBar();
        }
      }
      if (event.processingState == ProcessingState.completed) {
        if (mounted) {
          setState(() {
            isPlaying = false;
            position = Duration.zero;
          });
        }
      }
    });
    player.positionStream.listen((p) {
      if (mounted) {
        setState(() {
          position = p;
        });
      }
    });
    player.durationStream.listen((d) {
      if (mounted) {
        setState(() {
          duration = d ?? Duration.zero;
        });
      }
    });
  }

  windowThumbnailBar() {
    WindowsTaskbar.setThumbnailTooltip('Awesome Flutter window.');
    WindowsTaskbar.setFlashTaskbarAppIcon();

    WindowsTaskbar.setThumbnailToolbar([
      ThumbnailToolbarButton(
        ThumbnailToolbarAssetIcon('assets/img/skip_previous.ico'),
        "بعد",
        () async {
          final surahID = ref.read(surahIDProvider) + 1;
          await ref.read(seekIDProvider(surahID: surahID).future);
        },
      ),
      isPlaying
          ? ThumbnailToolbarButton(
              ThumbnailToolbarAssetIcon('assets/img/pause.ico'),
              "ايقاف ",
              () {
                player.pause();
                setState(() {
                  isPlaying = false;
                });
              },
            )
          : ThumbnailToolbarButton(
              ThumbnailToolbarAssetIcon('assets/img/play.ico'),
              "تشغيل",
              () {
                player.play();
                setState(() {
                  isPlaying = true;
                });
              },
            ),
      ThumbnailToolbarButton(
        ThumbnailToolbarAssetIcon('assets/img/skip_next.ico'),
        "قبل",
        () async {
          final surahID = ref.read(surahIDProvider) - 1;
          await ref.read(seekIDProvider(surahID: surahID).future);
        },
      ),
    ]);
  }

  Future<void> handlePlayPause() async {
    if (mounted) {
      setState(() {
        isPlaying = !isPlaying;
      });
    }

    if (player.playing) {
      await player.pause();
    } else {
      await player.play();
    }
  }

  Future<void> handleSeek(double value) async {
    await player.seek(
      Duration(seconds: value.toInt()),
    );
  }

  void handleVolume(double value) {
    player.setVolume(value);
    if (mounted) {
      setState(() {});
    }
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    String hoursStr = hours > 0 ? '$hours:' : '';
    String minutesStr = twoDigits(minutes);
    String secondsStr = twoDigits(seconds);

    return '$hoursStr$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    String currentTime = formatDuration(position);
    String durationTime = formatDuration(duration);
    ref.listen(playerSurahProvider, (p, n) {
      isPlaying = false;
      player.setUrl(n.url, preload: true);
    });
    return SizedBox.shrink(
      child: Container(
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
                              visible: ref.watch(surahIDProvider) > 1,
                              child: Tooltip(
                                message: "قبل",
                                preferBelow: false,
                                child: IconButton(
                                  onPressed: () async {
                                    final surahID =
                                        ref.read(surahIDProvider) - 1;
                                    await ref.read(
                                        seekIDProvider(surahID: surahID)
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
                              child: CallbackShortcuts(
                                bindings: <ShortcutActivator, VoidCallback>{
                                  const SingleActivator(
                                          LogicalKeyboardKey.space):
                                      () => handlePlayPause()
                                },
                                child: Focus(
                                  autofocus: true,
                                  child: IconButton(
                                    onPressed: () => handlePlayPause(),
                                    icon: isPlaying
                                        ? const Icon(
                                            Icons.pause_circle_filled_outlined)
                                        : const Icon(
                                            Icons.play_circle_fill_outlined),
                                    iconSize: 25,
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: ref.watch(surahIDProvider) < 114,
                              child: Tooltip(
                                message: "بعد",
                                preferBelow: false,
                                child: IconButton(
                                  onPressed: () async {
                                    final surahID =
                                        ref.read(surahIDProvider) + 1;
                                    await ref.read(
                                        seekIDProvider(surahID: surahID)
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
                            Text(currentTime),
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
                                      value: position.inSeconds.toDouble(),
                                      min: 0.0,
                                      max: duration.inSeconds.toDouble(),
                                      onChanged: (v) => handleSeek(v)),
                                );
                              }),
                            ),
                            Text(durationTime),
                          ],
                        ),
                      ],
                    ),
                  ),
                  VolumeControls(
                    player: player,
                    handleVolume: handleVolume,
                  ),
                ]),
          )),
    );
  }
}

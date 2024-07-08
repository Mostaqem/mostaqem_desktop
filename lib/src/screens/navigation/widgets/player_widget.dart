import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mostaqem/src/screens/home/widgets/surah_widget.dart';
import 'package:mostaqem/src/screens/navigation/repository/fullscreen_notifier.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/shared/widgets/hover_builder.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';
import 'package:window_manager/window_manager.dart';

import '../../../core/routes/routes.dart';
import '../../home/providers/home_providers.dart';
import 'volume_control.dart';

final playerSurahProvider = StateProvider((ref) => (
      name: "الفاتحة",
      reciter: "عبدالباسط",
      english: "Al-Fatiha",
      image:
          "https://img.freepik.com/premium-photo/illustration-mosque-with-crescent-moon-stars-simple-shapes-minimalist-flat-design_217051-15556.jpg",
      url: "https://download.quranicaudio.com/qdc/abdul_baset/mujawwad/1.mp3"
    ));

final isCollapsedProvider = StateProvider<bool>((ref) => false);

class PlayerWidget extends ConsumerStatefulWidget {
  const PlayerWidget({
    super.key,
  });

  @override
  ConsumerState<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends ConsumerState<PlayerWidget> {
  Timer? _timer;
  bool _isVisible = true;

  void _resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
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
    bool isFullScreen = ref.watch(isFullScreenProvider);

    return MouseRegion(
      onHover: (event) {
        if (isFullScreen) {
          _resetTimer();
        }
      },
      child: Visibility(
        visible: isFullScreen ? _isVisible : true,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    color: isFullScreen
                        ? Colors.transparent
                        : Theme.of(context).colorScheme.secondaryContainer),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: !isFullScreen,
                          child: Row(
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
                                    Row(
                                      children: [
                                        Text(
                                          surah.name,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondaryContainer),
                                        ),
                                        IconButton(
                                            onPressed: () => ref
                                                .read(isCollapsedProvider
                                                    .notifier)
                                                .update((state) => !state),
                                            icon: Icon(
                                              Icons.arrow_drop_up_outlined,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondaryContainer,
                                            )),
                                      ],
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
                        ),
                        Row(
                          children: [
                            Visibility(
                              visible: !isFullScreen,
                              child: ToolTipIconButton(
                                message: "اقرأ",
                                onPressed: () async {
                                  final surahID = ref.read(surahIDProvider);
                                  final surahName =
                                      ref.read(playerSurahProvider).name;

                                  ref.watch(goRouterProvider).goNamed(
                                        'Reading',
                                        extra: surahID,
                                      );
                                  final reciter = ref.read(reciterProvider);
                                  final currentID = ref.read(surahIDProvider);
                                  if (currentID != surahID) {
                                    await ref.read(seekIDProvider(
                                            surahID: surahID,
                                            reciter: reciter,
                                            surahName: surahName)
                                        .future);
                                  }
                                },
                                icon: SvgPicture.asset(
                                  "assets/img/read.svg",
                                  width: 16,
                                  colorFilter: ColorFilter.mode(
                                      Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer,
                                      BlendMode.srcIn),
                                ),
                              ),
                            ),
                            const VolumeControls(),
                            ToolTipIconButton(
                              onPressed: () async {
                                if (await windowManager.isFullScreen()) {
                                  windowManager.setFullScreen(false);
                                  ref
                                      .read(isFullScreenProvider.notifier)
                                      .toggle(false);
                                } else {
                                  windowManager.setFullScreen(true);
                                  ref
                                      .read(isFullScreenProvider.notifier)
                                      .toggle(true);
                                }
                              },
                              icon: Icon(
                                isFullScreen
                                    ? Icons.close_fullscreen_outlined
                                    : Icons.open_in_full_outlined,
                                size: 16,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                              message: isFullScreen
                                  ? "تصغير الشاشة"
                                  : "تكبير الشاشة",
                            )
                          ],
                        ),
                      ]),
                )),
            Transform.scale(
              scale: isFullScreen ? 1.3 : 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Row(
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
                                final surahID = ref.read(surahIDProvider) - 1;
                                await ref.read(seekIDProvider(
                                        surahID: surahID,
                                        reciter: ref.read(reciterProvider))
                                    .future);
                              },
                              icon: Icon(
                                Icons.skip_next_outlined,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
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
                                ? Icon(
                                    Icons.pause_circle_filled_outlined,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer,
                                  )
                                : Icon(
                                    Icons.play_circle_fill_outlined,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer,
                                  ),
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
                                final surahID = ref.read(surahIDProvider) + 1;
                                await ref.read(seekIDProvider(
                                        surahID: surahID,
                                        reciter: ref.read(reciterProvider))
                                    .future);
                              },
                              icon: Icon(
                                Icons.skip_previous_outlined,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                              iconSize: 25,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(ref
                          .watch(playerNotifierProvider.notifier)
                          .playerTime()
                          .$1),
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: 500, maxHeight: 10),
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
                                    .watch(playerNotifierProvider.notifier)
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
          ],
        ),
      ),
    );
  }
}

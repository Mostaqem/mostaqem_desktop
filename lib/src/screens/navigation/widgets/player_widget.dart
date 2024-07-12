import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mostaqem/src/screens/home/widgets/surah_widget.dart';
import 'package:mostaqem/src/screens/navigation/repository/fullscreen_notifier.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';
import 'package:window_manager/window_manager.dart';

import '../../../core/routes/routes.dart';
import '../../home/providers/home_providers.dart';
import 'play_controls.dart';
import 'playing_surah.dart';
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
        child: Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                color: isFullScreen
                    ? Colors.transparent
                    : Theme.of(context).colorScheme.secondaryContainer),
            child: isFullScreen
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FullScreenPlayControls(
                        ref: ref,
                      ),
                      const Expanded(child: VolumeControls()),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PlayingSurah(
                            isFullScreen: isFullScreen,
                            ref: ref,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 150),
                            child: PlayControls(
                              isFullScreen: isFullScreen,
                              ref: ref,
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
                                    ref
                                        .read(isFullScreenProvider.notifier)
                                        .toggle(false);
                                  } else {
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
                                  color: isFullScreen
                                      ? Colors.white
                                      : Theme.of(context)
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
      ),
    );
  }
}

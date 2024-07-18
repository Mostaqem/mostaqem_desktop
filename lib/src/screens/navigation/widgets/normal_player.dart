import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/routes/routes.dart';
import '../../../shared/widgets/tooltip_icon.dart';
import 'full_screen_controls.dart';
import 'play_controls.dart';
import 'player_widget.dart';
import 'playing_surah.dart';
import 'volume_control.dart';

class NormalPlayer extends StatelessWidget {
  const NormalPlayer({
    super.key,
    required this.isFullScreen,
    required this.ref,
  });

  final bool isFullScreen;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        PlayingSurah(
          isFullScreen: isFullScreen,
          ref: ref,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 50),
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
                  final surahID = ref.read(playerSurahProvider).surah.id;

                  ref.watch(goRouterProvider).goNamed(
                        'Reading',
                        extra: surahID,
                      );
                },
                icon: SvgPicture.asset(
                  "assets/img/read.svg",
                  width: 16,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onSecondaryContainer,
                      BlendMode.srcIn),
                ),
              ),
            ),
            const VolumeControls(),
            FullScreenControl(ref: ref, isFullScreen: isFullScreen)
          ],
        ),
      ]),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';

import '../../../shared/widgets/hover_builder.dart';
import '../repository/fullscreen_notifier.dart';

class VolumeControls extends ConsumerWidget {
  const VolumeControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerNotifierProvider);
    bool isFullScreen = ref.watch(isFullScreenProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Tooltip(
          message: player.volume > 0 ? "صامت" : "تشغيل",
          preferBelow: false,
          child: RotatedBox(
            quarterTurns: 2,
            child: IconButton(
              onPressed: () {
                if (player.volume > 0) {
                  ref.read(playerNotifierProvider.notifier).handleVolume(0);
                } else {
                  ref.read(playerNotifierProvider.notifier).handleVolume(1);
                }
              },
              icon: player.volume == 0
                  ? const Icon(
                      Icons.volume_mute_outlined,
                      size: 16,
                    )
                  : const Icon(
                      Icons.volume_up_outlined,
                      size: 16,
                    ),
              color: isFullScreen
                  ? Colors.white
                  : Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ),
        HoverBuilder(builder: (isHovered) {
          return SliderTheme(
            data: SliderThemeData(
                thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: isHovered ? 7 : 3,
              elevation: 0,
            )),
            child: SizedBox(
              width: 140,
              child: Slider(
                activeColor: isFullScreen ? Colors.white : null,
                value: ref.watch(playerNotifierProvider).volume,
                onChanged: (v) =>
                    ref.read(playerNotifierProvider.notifier).handleVolume(v),
              ),
            ),
          );
        }),
      ],
    );
  }
}

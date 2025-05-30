import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/play_controls.dart';
import 'package:mostaqem/src/screens/settings/appearance/providers/squiggly_notifier.dart';
import 'package:mostaqem/src/shared/widgets/hover_builder.dart';

class BroadcastControls extends ConsumerStatefulWidget {
  const BroadcastControls({super.key});

  @override
  ConsumerState<BroadcastControls> createState() => _BroadcastControlsState();
}

class _BroadcastControlsState extends ConsumerState<BroadcastControls>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final player = ref.watch(playerNotifierProvider);
    final isSquiggly = ref.watch(squigglyNotifierProvider);

    if (player.isPlaying) {
      controller.reverse();
    } else {
      controller.forward();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Tooltip(
          message: 'تشغيل',
          preferBelow: false,
          child: IconButton(
            color: Theme.of(context).colorScheme.onPrimary,

            onPressed: () async {
              await ref.read(playerNotifierProvider.notifier).handlePlayPause();
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.primary,
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            icon: AnimatedIcon(
              icon: AnimatedIcons.pause_play,
              progress: animation,
            ),

            iconSize: 30,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ref
                  .watch(playerNotifierProvider.notifier)
                  .playerTime()
                  .currentTime,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width / 2.5,
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
            ),
          ],
        ),
      ],
    );
  }
}

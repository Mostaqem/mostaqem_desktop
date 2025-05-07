import 'package:flutter/material.dart';
import 'package:mostaqem/src/screens/fullscreen/widgets/full_screen_controls.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/broadcast/Playing_broadcast.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/broadcast/broadcast_controls.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/volume_control.dart';

class BroadcastPlayer extends StatelessWidget {
  const BroadcastPlayer({required this.isFullScreen, super.key});
  final bool isFullScreen;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const PlayingBroadcast(),
          const Padding(
            padding: EdgeInsets.only(right: 80),
            child: BroadcastControls(),
          ),
          Row(
            children: [
              const VolumeControls(),
              FullScreenControl(isFullScreen: isFullScreen),
            ],
          ),
        ],
      ),
    );
  }
}

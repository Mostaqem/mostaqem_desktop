import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../shared/widgets/hover_builder.dart';

class VolumeControls extends StatefulWidget {
  const VolumeControls({super.key, required this.player, this.handleVolume});
  final AudioPlayer player;
  final Function(double)? handleVolume;

  @override
  State<VolumeControls> createState() => _VolumeControlsState();
}

class _VolumeControlsState extends State<VolumeControls> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Tooltip(
          message: widget.player.volume > 0 ? "صامت" : "تشغيل",
          preferBelow: false,
          child: RotatedBox(
            quarterTurns: 2,
            child: IconButton(
              onPressed: () {
                if (widget.player.volume > 0) {
                  widget.player.setVolume(0);
                } else {
                  widget.player.setVolume(1);
                }
                setState(() {});
              },
              icon: widget.player.volume == 0
                  ? const Icon(Icons.volume_mute_outlined)
                  : const Icon(Icons.volume_up_outlined),
              color: Theme.of(context).colorScheme.onSecondaryContainer,
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
            child: Slider(
              value: widget.player.volume,
              onChanged: widget.handleVolume,
            ),
          );
        }),
      ],
    );
  }
}

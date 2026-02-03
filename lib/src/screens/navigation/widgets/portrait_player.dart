import 'package:flutter/material.dart';
import 'package:flutter_m3shapes/flutter_m3shapes.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/play_controls.dart';

class PortraitPlayer extends StatelessWidget {
  const PortraitPlayer({
    required this.height,
    required this.album,
    required this.width,
    super.key,
  });

  final Album? album;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        spacing: 10,
        children: [
          Visibility(
            visible: height > 600,
            child: M3Container.c4SidedCookie(
              width: width - 150,
              height: width - 150,
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
          ),
          const PlayControls(),

          Text(
            album!.surah.name,
            style: TextStyle(
              fontSize: width / 7,
              fontFamily: 'Daken',
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Text(
            album!.reciter.name,
            style: TextStyle(
              fontSize: width / 20,
              height: 0.1,
              color: Theme.of(
                context,
              ).colorScheme.secondary.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

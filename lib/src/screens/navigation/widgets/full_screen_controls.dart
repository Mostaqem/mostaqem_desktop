import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/navigation/repository/fullscreen_notifier.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';
import 'package:window_manager/window_manager.dart';

class FullScreenControl extends StatelessWidget {
  const FullScreenControl({
    required this.ref, required this.isFullScreen, super.key,
  });

  final WidgetRef ref;
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    return ToolTipIconButton(
      onPressed: () async {
        if (await windowManager.isFullScreen()) {
          ref.read(isFullScreenProvider.notifier).toggle(value: false);
        } else {
          ref.read(isFullScreenProvider.notifier).toggle(value: true);
        }
      },
      icon: Icon(
        isFullScreen
            ? Icons.close_fullscreen_outlined
            : Icons.open_in_full_outlined,
        size: 16,
        color: isFullScreen
            ? Colors.white
            : Theme.of(context).colorScheme.onSecondaryContainer,
      ),
      message: isFullScreen ? 'تصغير الشاشة' : 'تكبير الشاشة',
    );
  }
}

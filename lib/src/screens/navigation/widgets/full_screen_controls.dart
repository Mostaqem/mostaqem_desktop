import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import '../../../shared/widgets/tooltip_icon.dart';
import '../repository/fullscreen_notifier.dart';

class FullScreenControl extends StatelessWidget {
  const FullScreenControl({
    super.key,
    required this.ref,
    required this.isFullScreen,
  });

  final WidgetRef ref;
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    return ToolTipIconButton(
      onPressed: () async {
        if (await windowManager.isFullScreen()) {
          ref.read(isFullScreenProvider.notifier).toggle(false);
        } else {
          ref.read(isFullScreenProvider.notifier).toggle(true);
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
      message: isFullScreen ? "تصغير الشاشة" : "تكبير الشاشة",
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';
import 'package:mostaqem/src/screens/navigation/repository/fullscreen_notifier.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/download_manager.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/recitation_widget.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';
import 'package:window_manager/window_manager.dart';

class FullScreenControl extends ConsumerWidget {
  const FullScreenControl({required this.isFullScreen, super.key});

  final bool isFullScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ToolTipIconButton(
      onPressed: () async {
        if (await windowManager.isFullScreen()) {
          ref.read(isFullScreenProvider.notifier).toggle(value: false);
        } else {
          ref.read(isFullScreenProvider.notifier).toggle(value: true);
          ref.read(recitationHeight.notifier).state = 0;
          ref.read(downloadHeightProvider.notifier).state = 0;

          if (!context.mounted) return;

          ref.read(goRouterProvider).go('/');
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
      message: isFullScreen
          ? context.tr.minimize_screen
          : context.tr.maximize_screen,
    );
  }
}

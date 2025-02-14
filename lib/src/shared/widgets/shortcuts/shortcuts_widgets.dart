import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/screens/navigation/repository/fullscreen_notifier.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/shared/widgets/app_menu_bar.dart';
import 'package:mostaqem/src/shared/widgets/shortcuts/shortcuts_enum.dart';
import 'package:mostaqem/src/shared/widgets/shortcuts/shortcuts_label.dart';

class AppShortcuts extends ConsumerWidget {
  const AppShortcuts({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CallbackShortcuts(
      bindings: shortcutsBindings(context, ref),
      child: child,
    );
  }
}

Dialog helpShortcuts(BuildContext context) {
  return Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 300, vertical: 100),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: SizedBox(
      height: ShortcutsEnum.values.length * 100,
      width: 500,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Align(alignment: Alignment.topLeft, child: CloseButton()),
                const Text(
                  'الاختصارات',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Divider(),
                ),
                const SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                      ShortcutsEnum.values
                          .map((e) => ShortcutLabel(shortcut: e))
                          .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Map<ShortcutActivator, VoidCallback> shortcutsBindings(
  BuildContext context,
  WidgetRef ref,
) {
  final bindings = <ShortcutActivator, VoidCallback>{};

  for (final shortcut in ShortcutsEnum.values) {
    switch (shortcut) {
      case ShortcutsEnum.playPause:
        bindings[shortcut.activator] =
            ref.read(playerNotifierProvider.notifier).handlePlayPause;

      case ShortcutsEnum.mute:
        bindings[shortcut.activator] = () {
          final volume = ref.read(playerNotifierProvider).volume;
          if (volume > 0) {
            ref.read(playerNotifierProvider.notifier).handleVolume(0);
          } else {
            ref.read(playerNotifierProvider.notifier).handleVolume(1);
          }
        };
      case ShortcutsEnum.settings:
        bindings[shortcut.activator] =
            () => ref.read(goRouterProvider).push('/settings');
      case ShortcutsEnum.checkUpdate:
        bindings[shortcut.activator] = () => checkUpdateDialog(context, ref);
      case ShortcutsEnum.exitFullscreen:
        bindings[shortcut.activator] = () {
          if (ref.read(isFullScreenProvider)) {
            ref.read(isFullScreenProvider.notifier).toggle(value: false);
          }
        };
      case ShortcutsEnum.quit:
        bindings[shortcut.activator] = () => exit(0);
      case ShortcutsEnum.help:
        bindings[shortcut.activator] = () {
          showDialog<Dialog>(context: context, builder: helpShortcuts);
        };
      case ShortcutsEnum.playNext:
        bindings[shortcut.activator] =
            ref.read(playerNotifierProvider.notifier).playNext;
      case ShortcutsEnum.playPrevious:
        bindings[shortcut.activator] =
            ref.read(playerNotifierProvider.notifier).playPrevious;
      case ShortcutsEnum.repeat:
        bindings[shortcut.activator] =
            ref.read(playerNotifierProvider.notifier).loop;
      case ShortcutsEnum.enterFullscreen:
        bindings[shortcut.activator] = () {
          if (!ref.read(isFullScreenProvider)) {
            ref.read(isFullScreenProvider.notifier).toggle(value: true);
          }
        };
    }
  }

  return bindings;
}

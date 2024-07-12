import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/navigation/repository/fullscreen_notifier.dart';
import 'package:window_manager/window_manager.dart';

import '../../screens/navigation/repository/player_repository.dart';

class AppShortcuts extends ConsumerWidget {
  const AppShortcuts({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.space):
            ref.watch(playerNotifierProvider.notifier).handlePlayPause,
        const SingleActivator(LogicalKeyboardKey.keyQ, control: true): () =>
            exit(0),
        const SingleActivator(
          LogicalKeyboardKey.escape,
        ): () {
          if (ref.read(isFullScreenProvider)) {
            ref.read(isFullScreenProvider.notifier).toggle(false);
            windowManager.setFullScreen(false);
          }
        },
        const SingleActivator(LogicalKeyboardKey.f1): () =>
            helpShortcuts(context),
      },
      child: child,
    );
  }
}

Future<dynamic> helpShortcuts(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) => Dialog(
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 300, vertical: 100),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: SizedBox(
              height: 300,
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                        alignment: Alignment.topLeft, child: CloseButton()),
                    const Text(
                      "الاختصارات",
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Divider(),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("تشغيل و ايقاف"),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inverseSurface)),
                          child: const Text("Space"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ));
}

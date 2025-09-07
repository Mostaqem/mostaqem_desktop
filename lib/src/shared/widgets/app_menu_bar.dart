import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';
import 'package:mostaqem/src/shared/device/device_repository.dart';
import 'package:mostaqem/src/shared/device/package_repository.dart';
import 'package:mostaqem/src/shared/widgets/shortcuts/shortcuts_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

class AppMenuBar extends ConsumerWidget {
  const AppMenuBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenuBar(
      style: MenuStyle(
        shape: const WidgetStatePropertyAll(BeveledRectangleBorder()),
        backgroundColor: WidgetStatePropertyAll<Color>(
          Theme.of(context).colorScheme.surface,
        ),
      ),
      children: [
        SubmenuButton(
          menuChildren: [
            MenuItemButton(
              onPressed: () async {
                final deviceInfo = await DeviceRepository().deviceInfo();
                final deviceID = await DeviceRepository().deviceID();
                final currentVersion = await ref.read(
                  getCurrentVersionProvider.future,
                );
                if (!context.mounted) return;

                return showAdaptiveDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              ref.read(goRouterProvider).push('/licenses');
                            },
                            child: Text(context.tr.licenses),
                          ),
                        ],
                        content: SizedBox(
                          height: 250,
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: CloseButton(),
                                ),
                                Text(
                                  context.tr.about_mostaqem,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(deviceInfo),
                                Text(deviceID),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(currentVersion),
                                    Tooltip(
                                      message: context.tr.copy_version,
                                      preferBelow: false,
                                      child: IconButton(
                                        onPressed: () async {
                                          final device = '''
                                                  Device: $deviceInfo
                                                  Build Number: $deviceID
                                                  AppVersion: $currentVersion
                                                  ''';
                                          await Clipboard.setData(
                                            ClipboardData(text: device),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.copy_all_outlined,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        if (!await launchUrl(
                                          Uri.parse(
                                            'https://github.com/mezopeeta/mostaqem',
                                          ),
                                        )) {
                                          log('[Couldnt Open Github URL]');
                                        }
                                      },
                                      icon: const VectorGraphic(
                                        colorFilter: ColorFilter.mode(
                                          Colors.white,
                                          BlendMode.srcIn,
                                        ),
                                        width: 30,
                                        loader: AssetBytesLoader(
                                          'assets/img/svg/github.svg',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                );
              },
              child: Text(context.tr.about_mostaqem),
            ),
            MenuItemButton(
              shortcut: const SingleActivator(LogicalKeyboardKey.f1),
              onPressed:
                  () => showDialog<Dialog>(
                    context: context,
                    builder: helpShortcuts,
                  ),
              child: Text(context.tr.shortcuts),
            ),
            MenuItemButton(
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyP,
                control: true,
              ),
              onPressed: () => context.push('/settings'),
              child: Text(context.tr.settings),
            ),
            Visibility(
              child: MenuItemButton(
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.keyU,
                  control: true,
                ),
                onPressed: () async {
                  await checkUpdateDialog(context, ref);
                },
                child: Text(context.tr.update_available),
              ),
            ),
            MenuItemButton(
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyQ,
                control: true,
              ),
              onPressed: () => exit(0),
              child: Text(context.tr.exit),
            ),
          ],
          child: const Icon(Icons.more_horiz_outlined),
        ),
      ],
    );
  }
}

Future<void> checkUpdateDialog(BuildContext context, WidgetRef ref) async {
  final updateState = await ref.watch(checkUpdateProvider.future);
  final updateAvailable = updateState == UpdateState.available;
  if (!context.mounted) return;

  return showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          content:
              updateAvailable
                  ? Text(context.tr.yes_update_available)
                  : Text(context.tr.no_update_available),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.tr.cancel),
            ),
            Visibility(
              visible: updateAvailable,
              child: TextButton(
                onPressed: () => ref.read(downloadUpdateProvider),
                child: Text(context.tr.update),
              ),
            ),
          ],
        ),
  );
}

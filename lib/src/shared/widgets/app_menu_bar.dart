import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/shared/device/device_repository.dart';
import 'package:mostaqem/src/shared/device/package_repository.dart';

import 'shortcuts.dart';
import 'package:url_launcher/url_launcher.dart';

class AppMenuBar extends ConsumerWidget {
  const AppMenuBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenuBar(
        style: MenuStyle(
            shape: const WidgetStatePropertyAll(BeveledRectangleBorder()),
            backgroundColor: WidgetStatePropertyAll<Color>(
                Theme.of(context).colorScheme.surface)),
        children: [
          SubmenuButton(menuChildren: [
            MenuItemButton(
              onPressed: () async {
                final deviceInfo = await DeviceRepository().deviceInfo();
                final deviceID = await DeviceRepository().deviceID();
                final currentVersion =
                    await PackageRepository().currentVersion();
                if (!context.mounted) return;

                return showAdaptiveDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  ref.read(goRouterProvider).push('/licenses');
                                },
                                child: const Text("التراخيص"))
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
                                      child: CloseButton()),
                                  const Text(
                                    "مستقيم",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
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
                                        message: "انسخ النسخة",
                                        preferBelow: false,
                                        child: IconButton(
                                            onPressed: () async {
                                              final String device = """
                                                  Device: $deviceInfo
                                                  Build Number: $deviceID
                                                  AppVersion: $currentVersion
                                                  """;
                                              await Clipboard.setData(
                                                  ClipboardData(text: device));
                                            },
                                            icon: const Icon(
                                                Icons.copy_all_outlined)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            if (!await launchUrl(Uri.parse(
                                                "https://github.com/mezopeeta/mostaqem"))) {
                                              log("[Couldnt Open Github URL]");
                                            }
                                          },
                                          icon: SvgPicture.asset(
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                      Colors.white,
                                                      BlendMode.srcIn),
                                              width: 30,
                                              "assets/img/github.svg"))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
              },
              child: const Text("عن مستقيم"),
            ),
            MenuItemButton(
              shortcut: const SingleActivator(
                LogicalKeyboardKey.f1,
              ),
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) => helpShortcuts(context)),
              child: const Text("الاختصارات"),
            ),
            MenuItemButton(
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyP,control: true
              ),
              onPressed: () => context.go("/settings"),
              child: const Text("الاعدادات"),
            ),
            MenuItemButton(
              shortcut:
                  const SingleActivator(LogicalKeyboardKey.keyU, control: true),
              onPressed: () async {
                checkUpdateDialog(context, ref);
              },
              child: const Text("تحديث؟"),
            ),
            MenuItemButton(
              shortcut:
                  const SingleActivator(LogicalKeyboardKey.keyQ, control: true),
              onPressed: () => exit(0),
              child: const Text("خروج"),
            ),
          ], child: const Icon(Icons.more_horiz_outlined))
        ]);
  }
}

Future<void> checkUpdateDialog(BuildContext context, WidgetRef ref) async {
  final UpdateState updateState = await PackageRepository().checkUpdate();
  final bool updateAvailable = updateState == UpdateState.available;
  if (!context.mounted) return;

  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: updateAvailable
                ? const Text("نعم هناك تحديث")
                : const Text("لا يوجد تحديث"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("الغاء")),
              Visibility(
                visible: updateAvailable,
                child: TextButton(
                    onPressed: () => PackageRepository().downloadUpdate(),
                    child: const Text("تحديث")),
              )
            ],
          ));
}

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'shortcuts.dart';
import 'package:url_launcher/url_launcher.dart';

class AppMenuBar extends StatelessWidget {
  const AppMenuBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MenuBar(
        style: MenuStyle(
            shape: const WidgetStatePropertyAll(BeveledRectangleBorder()),
            backgroundColor:
                WidgetStatePropertyAll(Theme.of(context).colorScheme.surface)),
        children: [
          SubmenuButton(menuChildren: [
            MenuItemButton(
              onPressed: () => showAdaptiveDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        actions: [
                          TextButton(
                              onPressed: () => context.push('/licenses'),
                              child: const Text("التراخيص"))
                        ],
                        content: SizedBox(
                          height: 220,
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                const Text("Windows (64-bit)"),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("1.0.0"),
                                    Tooltip(
                                      message: "انسخ النسخة",
                                      preferBelow: false,
                                      child: IconButton(
                                          onPressed: () async => await Clipboard
                                              .setData(const ClipboardData(
                                                  text:
                                                      "Windows (64-bit) 1.0.0")),
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
                                            colorFilter: const ColorFilter.mode(
                                                Colors.white, BlendMode.srcIn),
                                            width: 30,
                                            "assets/img/github.svg"))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
              child: const Text("عن مستقيم"),
            ),
            MenuItemButton(
              shortcut: const SingleActivator(
                LogicalKeyboardKey.f1,
              ),
              onPressed: () => helpShortcuts(context),
              child: const Text("الاختصارات"),
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

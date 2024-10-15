import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mostaqem/src/shared/widgets/app_menu_bar.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:window_manager/window_manager.dart';

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return UniversalPlatform.isWindows
        ? Directionality(
            textDirection: TextDirection.ltr,
            child: SizedBox(
              height: 30,
              child: WindowCaption(
                backgroundColor: Colors.transparent,
                brightness: Theme.of(context).brightness,
                title: const AppMenuBar(),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}

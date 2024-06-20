import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:mostaqem/src/shared/widgets/window_buttons.dart';

import 'app_menu_bar.dart';

class WindowBarBox extends StatelessWidget {
  const WindowBarBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  MoveWindow(),
                  const AppMenuBar(),
                ],
              ),
            ),
            const WindowButtons(),
          ],
        ),
      ),
    );
  }
}

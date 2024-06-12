import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/screens/screens.dart';

import '../../shared/widgets/tooltip_icon.dart';
import '../../shared/widgets/window_buttons.dart';
import 'widgets/player_widget.dart';

final isExtendedProvider = StateProvider<bool>((ref) => false);

class Navigation extends ConsumerWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final children = ref.watch(childrenProvider);
    final screenIndex = ref.watch(indexScreenProvider);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              WindowTitleBarBox(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    children: [
                      Expanded(
                        child: MoveWindow(),
                      ),
                      const WindowButtons(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: NavigationRail(
                            extended: ref.watch(isExtendedProvider),
                            leading: ToolTipIconButton(
                              message: "توسيع",
                              icon: const Icon(Icons.menu),
                              onPressed: () => ref
                                  .read(isExtendedProvider.notifier)
                                  .update((state) => !state),
                            ),
                            indicatorShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            destinations: [
                              ...children.map((child) =>
                                  NavigationRailDestination(
                                      icon: child.icon,
                                      label: Text(child.label),
                                      selectedIcon: child.selectedIcon))
                            ],
                            selectedIndex: screenIndex,
                            onDestinationSelected: (value) {
                              ref.read(indexScreenProvider.notifier).state =
                                  value;
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      child: children[screenIndex].widget,
                    )),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: PlayerWidget(),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mostaqem/src/core/screens/screens.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player_widget.dart';

import '../../shared/widgets/full_screen.dart';
import '../../shared/widgets/tooltip_icon.dart';
import '../../shared/widgets/window_buttons.dart';
import 'repository/fullscreen_notifier.dart';

final isExtendedProvider = StateProvider<bool>((ref) => false);

class Navigation extends ConsumerWidget {
  const Navigation({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isFullScreen = ref.watch(isFullScreenProvider);
    final player = ref.watch(playerSurahProvider);
    final children = ref.watch(childrenProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isFullScreen
          ? FullScreenWidget(player: player!, ref: ref)
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    const WindowButtons(),
                    Expanded(
                        child: Row(
                      children: [
                        RightSide(
                          children: children,
                        ),
                        LeftSide(child: child),
                      ],
                    )),
                  ],
                ),
              ],
            ),
    );
  }
}

class RightSide extends ConsumerWidget {
  const RightSide({
    super.key,
    required this.children,
  });
  final List<Screen> children;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenIndex = ref.watch(indexScreenProvider);
    final currentRoute = getCurrentRoutePath(context);
    bool isFocus = currentRoute == "/" || currentRoute == "/downloads";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: SizedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: NavigationRail(
            useIndicator: isFocus,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            extended: ref.watch(isExtendedProvider),
            leading: ToolTipIconButton(
              message: "توسيع",
              icon: const Icon(Icons.menu),
              onPressed: () => ref
                  .read(isExtendedProvider.notifier)
                  .update((state) => !state),
            ),
            indicatorShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            destinations: [
              ...children.map((child) => NavigationRailDestination(
                  icon: child.icon,
                  label: Text(child.label),
                  selectedIcon: isFocus ? child.selectedIcon : null))
            ],
            selectedIndex: screenIndex,
            onDestinationSelected: (value) {
              ref.read(indexScreenProvider.notifier).state = value;
              switch (value) {
                case 0:
                  context.go("/");
                  break;
                case 1:
                  context.go("/downloads");
                  break;
                default:
                  context.go("/");
                  break;
              }
            },
          ),
        ),
      ),
    );
  }
}

class LeftSide extends StatelessWidget {
  const LeftSide({
    super.key,
    // required this.children,
    required this.child,
  });

  // final List<Screen> children;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(right: 5, top: 5, left: 10),
      child: Container(
          padding: const EdgeInsets.all(18),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          child: child),
    ));
  }
}

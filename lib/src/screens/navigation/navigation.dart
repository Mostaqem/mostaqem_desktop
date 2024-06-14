import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/screens/screens.dart';

import '../../shared/widgets/tooltip_icon.dart';
import '../../shared/widgets/window_bar.dart';

final isExtendedProvider = StateProvider<bool>((ref) => false);

class Navigation extends ConsumerWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              const WindowBarBox(),
              Consumer(builder: (context, ref, child) {
                final children = ref.watch(childrenProvider);
                final screenIndex = ref.watch(indexScreenProvider);
                return Expanded(
                  child: Row(
                    children: [
                      RightSide(children: children, screenIndex: screenIndex),
                      LeftSide(children: children, screenIndex: screenIndex),
                    ],
                  ),
                );
              }),
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
    required this.screenIndex,
  });
  final List<Screen> children;
  final int screenIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
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
            indicatorShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            destinations: [
              ...children.map((child) => NavigationRailDestination(
                  icon: child.icon,
                  label: Text(child.label),
                  selectedIcon: child.selectedIcon))
            ],
            selectedIndex: screenIndex,
            onDestinationSelected: (value) {
              ref.read(indexScreenProvider.notifier).state = value;
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
    required this.children,
    required this.screenIndex,
  });

  final List<Screen> children;
  final int screenIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: children[screenIndex].widget,
    ));
  }
}

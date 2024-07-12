import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/screens/screens.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player_widget.dart';

import '../../shared/widgets/tooltip_icon.dart';
import '../../shared/widgets/window_buttons.dart';
import 'repository/fullscreen_notifier.dart';

final isExtendedProvider = StateProvider<bool>((ref) => false);

class Navigation extends ConsumerWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isFullScreen = ref.watch(isFullScreenProvider);
    final player = ref.watch(playerSurahProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isFullScreen
          ? FullScreenWidget(
              player: player,
            )
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    const WindowButtons(),
                    Expanded(
                      child: Consumer(builder: (context, ref, child) {
                        final children = ref.watch(childrenProvider);
                        final screenIndex = ref.watch(indexScreenProvider);
                        return Row(
                          children: [
                            RightSide(
                                children: children, screenIndex: screenIndex),
                            LeftSide(
                                children: children, screenIndex: screenIndex),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class FullScreenWidget extends StatelessWidget {
  const FullScreenWidget({
    super.key,
    required this.player,
  });
  final ({
    String english,
    String name,
    String reciter,
    String url,
    String image
  }) player;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1686579809662-829e8374d0a8?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"))),
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
                Colors.black
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.5, 0.3, 1],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 220, right: 50),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(player.image))),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.name,
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Text(player.reciter,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.5))),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
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
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: SizedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: NavigationRail(
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
                  selectedIcon: child.selectedIcon))
            ],
            selectedIndex: screenIndex,
            onDestinationSelected: (value) =>
                ref.read(indexScreenProvider.notifier).state = value,
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
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: children[screenIndex].widget,
    ));
  }
}

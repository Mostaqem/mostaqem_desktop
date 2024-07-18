import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/screens/screens.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player_widget.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';

import '../../shared/widgets/tooltip_icon.dart';
import '../../shared/widgets/window_buttons.dart';
import 'data/album.dart';
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
          ? FullScreenWidget(player: player, ref: ref)
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
  const FullScreenWidget({super.key, required this.player, required this.ref});
  final Album player;
  final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    final randomImage = ref.watch(fetchRandomImageProvider);
    return Stack(
      children: [
        AsyncWidget(
            value: randomImage,
            data: (data) {
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(data))),
              );
            }),
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
                          image: CachedNetworkImageProvider(player
                                  .surah.image ??
                              "https://img.freepik.com/premium-photo/illustration-mosque-with-crescent-moon-stars-simple-shapes-minimalist-flat-design_217051-15556.jpg"))),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.surah.arabicName,
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Text(player.reciter.arabicName,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.5))),
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                child: IconButton(
                    onPressed: () {
                      ref.invalidate(fetchRandomImageProvider);
                    },
                    icon: const Icon(Icons.arrow_forward_outlined)),
              )),
        )
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/discord/discord_provider.dart';
import 'package:mostaqem/src/screens/fullscreen/widgets/full_screen_player_controls.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/repository/fullscreen_notifier.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_cache.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/broadcast/broadcast_player.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/broadcast/fullscreen_controls.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/normal_player.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:window_manager/window_manager.dart';

final isCollapsedProvider = StateProvider<bool>((ref) => false);

class PlayerWidget extends ConsumerStatefulWidget {
  const PlayerWidget({super.key});

  @override
  ConsumerState<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends ConsumerState<PlayerWidget>
    with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowClose() {
    final player = ref.read(currentAlbumProvider);
    if (player == null) return;

    final position = ref.watch(
      playerNotifierProvider.select((value) => value.position),
    );
    final duration = ref.watch(
      playerNotifierProvider.select((value) => value.duration),
    );

    ref
        .read(playerCacheProvider().notifier)
        .setAlbum(
          Album(
            surah: player.surah,
            reciter: player.reciter,
            url: player.url,
            position: position.inMilliseconds,
            recitationID: player.recitationID,
            duration: duration.inMilliseconds,
          ),
        );
    ref.read(clearRPCDiscordProvider);
    super.onWindowClose();
  }

  @override
  Widget build(BuildContext context) {
    final isFullScreen = ref.watch(isFullScreenProvider);
    final isBroadcast = ref.watch(isBroadcastProvider);
    return Stack(
      children: [
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            color: isFullScreen
                ? Colors.transparent
                : Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: isFullScreen
              ? isBroadcast
                    ? const BroadcastFullscreenControls()
                    : const FullScreenPlayControls()
              : LayoutBuilder(
                  builder: (context, constraints) {
                    return constraints.minWidth < 1285 && isBroadcast == false
                        ? FittedBox(
                            child: NormalPlayer(isFullScreen: isFullScreen),
                          )
                        : isBroadcast
                        ? BroadcastPlayer(isFullScreen: isFullScreen)
                        : NormalPlayer(isFullScreen: isFullScreen);
                  },
                ),
        ),
        Visibility(
          visible: ref.watch(currentAlbumProvider) == null,
          child: MouseRegion(
            cursor: SystemMouseCursors.forbidden,
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                color: Theme.of(
                  context,
                ).colorScheme.secondaryContainer.withValues(alpha: 0.4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

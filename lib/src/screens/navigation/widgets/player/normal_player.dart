import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';
import 'package:mostaqem/src/screens/fullscreen/widgets/full_screen_controls.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/repository/download_repository.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/broadcast/Playing_broadcast.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/download_manager.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/play_controls.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/playing_surah.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/volume_control.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/offline/repository/offline_repository.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

class NormalPlayer extends ConsumerStatefulWidget {
  const NormalPlayer({required this.isFullScreen, super.key});

  final bool isFullScreen;

  @override
  ConsumerState<NormalPlayer> createState() => _NormalPlayerState();
}

class _NormalPlayerState extends ConsumerState<NormalPlayer> {
  final List<Album> downloadedAlbums = [];

  bool isBtnVisible(Album? album) {
    final isOffline = ref.watch(currentAlbumProvider)?.isLocal ?? false;
    if (isOffline) {
      return false;
    }

    if (downloadedAlbums.contains(album)) {
      return false;
    }
    final isDownloaded = ref.watch(isAudioDownloaded).value ?? false;
    return !isDownloaded;
  }

  @override
  Widget build(BuildContext context) {
    final album = ref.watch(
      playerNotifierProvider.select((value) => value.album),
    );
    final isBroadcast = ref.watch(isBroadcastProvider);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isBroadcast)
            const PlayingBroadcast()
          else
            PlayingSurah(isFullScreen: widget.isFullScreen, ref: ref),
          const PlayControls(),
          Row(
            children: [
              MenuAnchor(
                alignmentOffset: const Offset(-25, 60), // small spacing above
                menuChildren: [
                  MenuItemButton(
                    leadingIcon: const Icon(Icons.share_outlined),
                    child: const Text('Share'),
                    onPressed: () {
                      if (album != null) {
                        final uri = Uri.parse(album.url);
                        final params = ShareParams(uri: uri, title: 'Share');
                        SharePlus.instance.share(params);
                      }
                    },
                  ),
                  MenuItemButton(
                    leadingIcon: VectorGraphic(
                      loader: const AssetBytesLoader('assets/img/svg/read.svg'),
                      width: 16,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onSecondaryContainer,
                        BlendMode.srcIn,
                      ),
                    ),
                    child: Text(context.tr.read),
                    onPressed: () {
                      final surah = ref.read(currentSurahProvider);

                      ref
                          .read(goRouterProvider)
                          .goNamed('Reading', extra: surah);
                    },
                  ),
                  MenuItemButton(
                    leadingIcon: const Icon(Icons.download_outlined),
                    child: Text(context.tr.download),
                    onPressed: () async {
                      final height = ref.read(downloadHeightProvider);
                      if (height == 100) {
                        ref.read(downloadHeightProvider.notifier).state = 0;
                      } else {
                        ref.read(downloadHeightProvider.notifier).state = 100;
                      }
                      ref.read(downloadSurahProvider.notifier).state =
                          album!.surah;
                      final downloadState = ref
                          .read(downloadAudioProvider)
                          ?.downloadState;
                      if (downloadState != DownloadState.downloading) {
                        await ref
                            .read(downloadAudioProvider.notifier)
                            .download();
                      }
                      setState(() {
                        downloadedAlbums.add(album);
                      });
                    },
                  ),
                ],
                builder: (context, controller, child) {
                  return IconButton(
                    onPressed: () {
                      controller.isOpen
                          ? controller.close()
                          : controller.open();
                    },
                    icon: const Icon(Icons.more_horiz),
                  );
                },
              ),

              const VolumeControls(),
              FullScreenControl(isFullScreen: widget.isFullScreen),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
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
          const Padding(
            padding: EdgeInsets.only(right: 80),
            child: PlayControls(),
          ),
          Row(
            children: [
              Visibility(
                visible: isBtnVisible(album),
                child: ToolTipIconButton(
                  message: 'تحميل',
                  iconSize: 16,
                  onPressed: () async {
                    final height = ref.read(downloadHeightProvider);
                    if (height == 100) {
                      ref.read(downloadHeightProvider.notifier).state = 0;
                    } else {
                      ref.read(downloadHeightProvider.notifier).state = 100;
                    }
                    ref.read(downloadSurahProvider.notifier).state =
                        album!.surah;
                    final downloadState =
                        ref.read(downloadAudioProvider)?.downloadState;
                    if (downloadState != DownloadState.downloading) {
                      await ref.read(downloadAudioProvider.notifier).download();
                    }
                    setState(() {
                      downloadedAlbums.add(album);
                    });
                  },
                  icon: const Icon(Icons.download_for_offline),
                ),
              ),
              Visibility(
                visible:
                    !widget.isFullScreen &&
                    ref.watch(downloadHeightProvider) == 0 &&
                    !ref.watch(isLocalProvider),
                child: ToolTipIconButton(
                  message: 'اقرأ',
                  onPressed: () async {
                    final surah = ref.read(currentSurahProvider);
                    final canPop = ref
                        .read(navigationProvider)
                        .canPop(expectedPath: '/reading');
                    if (canPop) {
                      ref.read(goRouterProvider).pop();
                      return;
                    }

                    ref.read(goRouterProvider).goNamed('Reading', extra: surah);
                  },
                  icon: VectorGraphic(
                    loader: const AssetBytesLoader('assets/img/svg/read.svg'),
                    width: 16,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onSecondaryContainer,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
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

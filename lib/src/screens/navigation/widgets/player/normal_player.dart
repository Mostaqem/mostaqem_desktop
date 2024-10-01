import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/screens/fullscreen/widgets/full_screen_controls.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/repository/download_repository.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/download_manager.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/play_controls.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/playing_surah.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/volume_control.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/offline/repository/offline_repository.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';

class NormalPlayer extends ConsumerStatefulWidget {
  const NormalPlayer({
    required this.isFullScreen,
    super.key,
  });

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
    final album =
        ref.watch(playerNotifierProvider.select((value) => value.album));

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PlayingSurah(
            isFullScreen: widget.isFullScreen,
            ref: ref,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 80),
            child: PlayControls(
              isFullScreen: widget.isFullScreen,
            ),
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
                      await ref
                          .read(downloadAudioProvider.notifier)
                          .download(album: album);
                    }
                    setState(() {
                      downloadedAlbums.add(album);
                    });
                  },
                  icon: const Icon(Icons.download_for_offline),
                ),
              ),
              Visibility(
                visible: !widget.isFullScreen &&
                    ref.watch(downloadHeightProvider) == 0 &&
                    !ref.watch(isLocalProvider),
                child: ToolTipIconButton(
                  message: 'اقرأ',
                  onPressed: () async {
                    final surah = ref.read(currentSurahProvider);

                    ref.read(goRouterProvider).goNamed(
                          'Reading',
                          extra: surah,
                        );
                  },
                  icon: SvgPicture.asset(
                    'assets/img/read.svg',
                    width: 16,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onSecondaryContainer,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const VolumeControls(),
              FullScreenControl(
                isFullScreen: widget.isFullScreen,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

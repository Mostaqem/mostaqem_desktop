import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/repository/download_repository.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/download_manager.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/full_screen_controls.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/play_controls.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/player_widget.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/playing_surah.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/volume_control.dart';
import 'package:mostaqem/src/screens/offline/repository/offline_repository.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';

class NormalPlayer extends StatefulWidget {
  const NormalPlayer({
    required this.isFullScreen,
    required this.ref,
    super.key,
  });

  final bool isFullScreen;
  final WidgetRef ref;

  @override
  State<NormalPlayer> createState() => _NormalPlayerState();
}

class _NormalPlayerState extends State<NormalPlayer> {
  final List<Album> downloadedAlbums = [];

  bool isBtnVisible(Album? album) {
    final isOffline =
        widget.ref.watch(playerNotifierProvider.notifier).isLocalAudio();
    if (isOffline) {
      return false;
    }

    if (downloadedAlbums.contains(album)) {
      return false;
    }
    final isDownloaded = widget.ref.watch(isAudioDownloaded).value ?? false;
    return !isDownloaded;
  }

  @override
  Widget build(BuildContext context) {
    final album = widget.ref.watch(playerSurahProvider);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PlayingSurah(
            isFullScreen: widget.isFullScreen,
            ref: widget.ref,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 80),
            child: PlayControls(
              isFullScreen: widget.isFullScreen,
              ref: widget.ref,
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
                    final height = widget.ref.read(downloadHeightProvider);
                    if (height == 100) {
                      widget.ref.read(downloadHeightProvider.notifier).state =
                          0;
                    } else {
                      widget.ref.read(downloadHeightProvider.notifier).state =
                          100;
                    }
                    widget.ref.read(downloadSurahProvider.notifier).state =
                        album!.surah;
                    final downloadState =
                        widget.ref.read(downloadAudioProvider)?.downloadState;
                    if (downloadState != DownloadState.downloading) {
                      await widget.ref
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
                    !widget.ref
                        .read(playerNotifierProvider.notifier)
                        .isLocalAudio(),
                child: ToolTipIconButton(
                  message: 'اقرأ',
                  onPressed: () async {
                    final surahID =
                        widget.ref.read(playerSurahProvider)!.surah.id;

                    widget.ref.watch(goRouterProvider).goNamed(
                          'Reading',
                          extra: surahID,
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
                ref: widget.ref,
                isFullScreen: widget.isFullScreen,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

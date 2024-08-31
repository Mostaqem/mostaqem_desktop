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

final downloadedAudiosProvider = StateProvider<Set<Album>>((ref) => {});

class NormalPlayer extends StatelessWidget {
  const NormalPlayer({
    required this.isFullScreen,
    required this.ref,
    super.key,
  });

  final bool isFullScreen;
  final WidgetRef ref;

  bool isDownloadVisible() {
    final playingSurah = ref.watch(playerSurahProvider);
    final downloadedSurahs = ref.watch(downloadedAudiosProvider);

    if (downloadedSurahs.contains(playingSurah)) {
      return false;
    }

    final isDownloaded = ref.watch(isAudioDownloaded).value ?? false;
    final isLocalAudio =
        ref.watch(playerNotifierProvider.notifier).isLocalAudio();
    return !isLocalAudio && !isDownloaded;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PlayingSurah(
            isFullScreen: isFullScreen,
            ref: ref,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 80),
            child: PlayControls(
              isFullScreen: isFullScreen,
              ref: ref,
            ),
          ),
          Row(
            children: [
              Visibility(
                visible: isDownloadVisible(),
                child: ToolTipIconButton(
                  message: 'تحميل',
                  iconSize: 16,
                  onPressed: () async {
                    final album = ref.read(playerSurahProvider);

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
                    ref
                        .read(downloadedAudiosProvider.notifier)
                        .state
                        .add(album);
                  },
                  icon: const Icon(Icons.download_for_offline),
                ),
              ),
              Visibility(
                visible: !isFullScreen &&
                    !ref.read(playerNotifierProvider.notifier).isLocalAudio(),
                child: ToolTipIconButton(
                  message: 'اقرأ',
                  onPressed: () async {
                    final surahID = ref.read(playerSurahProvider)!.surah.id;

                    ref.watch(goRouterProvider).goNamed(
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
              FullScreenControl(ref: ref, isFullScreen: isFullScreen),
            ],
          ),
        ],
      ),
    );
  }
}

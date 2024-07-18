import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:smtc_windows/smtc_windows.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'smtc_provider.g.dart';

class SMTCRepository {
  final Ref ref;
  SMTCRepository(this.ref);
  late final SMTCWindows smtc;

  void init(
      {required String surah,
      required String reciter,
      required String image,
      required int position,
      required int duration}) {
    smtc = SMTCWindows(
      metadata: MusicMetadata(
        title: surah,
        albumArtist: reciter,
        artist: reciter,
        thumbnail: image,
      ),
      timeline: PlaybackTimeline(
        startTimeMs: 0,
        endTimeMs: duration,
        positionMs: position,
        minSeekTimeMs: 0,
        maxSeekTimeMs: duration,
      ),
      config: const SMTCConfig(
        fastForwardEnabled: false,
        nextEnabled: true,
        pauseEnabled: true,
        playEnabled: true,
        rewindEnabled: false,
        prevEnabled: true,
        stopEnabled: true,
      ),
    );
    smtc.buttonPressStream.listen((event) {
      switch (event) {
        case PressedButton.play:
          ref.read(playerNotifierProvider.notifier).player.play();
          smtc.setPlaybackStatus(PlaybackStatus.Playing);
          break;
        case PressedButton.pause:
          ref.read(playerNotifierProvider.notifier).player.pause();

          smtc.setPlaybackStatus(PlaybackStatus.Paused);
          break;
        case PressedButton.next:
          ref.read(playerNotifierProvider.notifier).playNext();
          break;
        case PressedButton.previous:
          ref.read(playerNotifierProvider.notifier).playPrevious();

          break;
        case PressedButton.stop:
          smtc.setPlaybackStatus(PlaybackStatus.Stopped);
          break;
        default:
          break;
      }
    });
  }

  void updateSMTC(
      {required String surah, required String reciter, required String image}) {
    smtc.updateMetadata(
      MusicMetadata(
        title: surah,
        albumArtist: reciter,
        thumbnail: image,
      ),
    );
  }
}

final smtcRepoProvider = Provider(SMTCRepository.new);

@riverpod
updateSMTC(UpdateSMTCRef ref,
    {required String surah, required String reciter, required String image}) {
  final repo = ref.watch(smtcRepoProvider);
  return repo.updateSMTC(surah: surah, reciter: reciter, image: image);
}

@riverpod
initSMTC(InitSMTCRef ref,
    {required String surah,
    required String reciter,
    required String image,
    required int position,
    required int duration}) {
  final repo = ref.watch(smtcRepoProvider);
  return repo.init(
      surah: surah,
      reciter: reciter,
      image: image,
      position: position,
      duration: duration);
}

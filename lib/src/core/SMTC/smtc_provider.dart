import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smtc_windows/smtc_windows.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'smtc_provider.g.dart';

class SMTCRepository {
  final Ref ref;
  SMTCRepository(this.ref);

  final SMTCWindows smtc = SMTCWindows(
    metadata: const MusicMetadata(
      title: 'Title',
      album: 'Album',
      albumArtist: 'Album Artist',
      artist: 'Artist',
      thumbnail:
          'https://t4.ftcdn.net/jpg/05/68/75/85/360_F_568758547_IhIOMXI9hKcyoUBRTdEKkSlTz0Yi6CWx.jpg',
    ),
    timeline: const PlaybackTimeline(
      startTimeMs: 0,
      endTimeMs: 1000,
      positionMs: 0,
      minSeekTimeMs: 0,
      maxSeekTimeMs: 1000,
    ),
    config: const SMTCConfig(
      fastForwardEnabled: true,
      nextEnabled: true,
      pauseEnabled: true,
      playEnabled: true,
      rewindEnabled: true,
      prevEnabled: true,
      stopEnabled: true,
    ),
  );

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

// final updateSMTCProvider = StateProvider((ref){
//   final repo = ref.watch(smtcRepoProvider);
//   return repo.updateSMTC(surah: surah, reciter: reciter, image: image)
// })

@riverpod
updateSMTC(UpdateSMTCRef ref,
    {required String surah, required String reciter, required String image}) {
  final repo = ref.watch(smtcRepoProvider);
  return repo.updateSMTC(surah: surah, reciter: reciter, image: image);
}

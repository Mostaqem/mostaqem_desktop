import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smtc_windows/smtc_windows.dart';

final smtcRepoProvider = Provider(SMTCRepository.new);

class SMTCRepository {
  final Ref ref;

  final SMTCWindows smtc = SMTCWindows(
    metadata: const MusicMetadata(
      title: 'Title',
      album: 'Album',
      albumArtist: 'Album Artist',
      artist: 'Artist',
      thumbnail:
          'https://t4.ftcdn.net/jpg/05/68/75/85/360_F_568758547_IhIOMXI9hKcyoUBRTdEKkSlTz0Yi6CWx.jpg',
    ),
    // Timeline info for the OS media player
    timeline: const PlaybackTimeline(
      startTimeMs: 0,
      endTimeMs: 1000,
      positionMs: 0,
      minSeekTimeMs: 0,
      maxSeekTimeMs: 1000,
    ),
    // Which buttons to show in the OS media player
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

  SMTCRepository(this.ref);
  void updateSMTC() {
    smtc.updateMetadata(
      const MusicMetadata(
        title: 'Title',
        album: 'Album',
        albumArtist: 'Album Artist',
        artist: 'Artist',
        thumbnail:
            'https://media.glamour.com/photos/5f4c44e20c71c58fc210d35f/master/w_2560%2Cc_limit/mgid_ao_image_mtv.jpg',
      ),
    );
  }
}

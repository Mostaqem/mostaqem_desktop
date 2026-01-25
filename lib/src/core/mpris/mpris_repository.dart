import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mpris_service/mpris_service.dart';

/// Singleton class to manage MPRIS instance
class MprisManager {
  MprisManager._();
  static final MprisManager _instance = MprisManager._();
  static MprisManager get instance => _instance;

  MPRIS? _mpris;
  bool _initialized = false;

  Future<MPRIS> init(Ref ref) async {
    if (_initialized && _mpris != null) {
      return _mpris!;
    }

    _mpris = await MPRIS.create(
      busName: 'org.mpris.MediaPlayer2.mostaqem',
      identity: 'Mostaqem',
      desktopEntry: '/usr/share/applications/mostaqem',
    );

    _mpris!.setEventHandler(
      MPRISEventHandler(
        seek: (offset) async {
          await ref.read(playerProvider.notifier).handleSeek(offset);
        },
        volume: (value) async {
          await ref.read(playerProvider.notifier).handleVolume(value);
        },
        playPause: () async {
          await ref.read(playerProvider.notifier).handlePlayPause();
        },
        play: () async {
          _mpris!.playbackStatus = MPRISPlaybackStatus.playing;
          await ref.read(playerProvider.notifier).player.play();
        },
        pause: () async {
          _mpris!.playbackStatus = MPRISPlaybackStatus.paused;
          await ref.read(playerProvider.notifier).player.pause();
        },
        next: () async {
          await ref.read(playerProvider.notifier).playNext();
        },
        previous: () async {
          await ref.read(playerProvider.notifier).playPrevious();
        },
      ),
    );

    _initialized = true;
    return _mpris!;
  }

  void updateMetadata({
    required String reciterName,
    required String surah,
    required String url,
    required Duration length,
  }) {
    if (_mpris == null) return;
    _mpris!.metadata = MPRISMetadata(
      Uri.parse(url),
      length: length,
      artist: [reciterName],
      title: surah,
    );
  }

  void updatePlaybackStatus({required bool isPlaying}) {
    if (_mpris == null) return;
    _mpris!.playbackStatus =
        isPlaying ? MPRISPlaybackStatus.playing : MPRISPlaybackStatus.paused;
  }

  void updatePosition({required Duration position}) {
    if (_mpris == null) return;
    _mpris!.position = position;
  }
}

/// Provider for MprisManager
final mprisManagerProvider = Provider<MprisManager>((ref) {
  return MprisManager.instance;
});

import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:smtc_windows/smtc_windows.dart';

/// Singleton class to manage SMTC instance
class SmtcManager {
  SmtcManager._();
  static final SmtcManager _instance = SmtcManager._();
  static SmtcManager get instance => _instance;

  SMTCWindows? _smtc;
  bool _initialized = false;
  PlayerNotifier? _playerNotifier;

  Future<void> init(PlayerNotifier playerNotifier) async {
    if (_initialized && _smtc != null) {
      return;
    }

    _playerNotifier = playerNotifier;

    _smtc = SMTCWindows(
      metadata: const MusicMetadata(
        title: 'Mostaqem',
        artist: 'Mostaqem',
        albumArtist: 'Mostaqem',
      ),
      timeline: const PlaybackTimeline(
        startTimeMs: 0,
        endTimeMs: 0,
        positionMs: 0,
        minSeekTimeMs: 0,
        maxSeekTimeMs: 0,
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

    _smtc!.buttonPressStream.listen((event) {
      switch (event) {
        case PressedButton.play:
          _playerNotifier?.player.play();
        case PressedButton.pause:
          _playerNotifier?.player.pause();
        case PressedButton.next:
          _playerNotifier?.playNext();
        case PressedButton.previous:
          _playerNotifier?.playPrevious();
        case PressedButton.stop:
          _playerNotifier?.player.pause();
        case PressedButton.fastForward:
        case PressedButton.rewind:
        case PressedButton.record:
        case PressedButton.channelUp:
        case PressedButton.channelDown:
          break;
      }
    });

    await _smtc!.enableSmtc();
    _initialized = true;
  }

  void updateMetadata({
    required String reciterName,
    required String surah,
    String? thumbnail,
  }) {
    if (_smtc == null) return;
    _smtc!.updateMetadata(
      MusicMetadata(
        title: surah,
        artist: reciterName,
        albumArtist: reciterName,
        thumbnail: thumbnail,
      ),
    );
  }

  void updateTimeline({
    required Duration position,
    required Duration duration,
  }) {
    if (_smtc == null) return;
    _smtc!.updateTimeline(
      PlaybackTimeline(
        startTimeMs: 0,
        endTimeMs: duration.inMilliseconds,
        positionMs: position.inMilliseconds,
        minSeekTimeMs: 0,
        maxSeekTimeMs: duration.inMilliseconds,
      ),
    );
  }

  void updatePlaybackStatus({required bool isPlaying}) {
    if (_smtc == null) return;
    _smtc!.setPlaybackStatus(
      isPlaying ? PlaybackStatus.playing : PlaybackStatus.paused,
    );
  }

  void dispose() {
    _smtc?.disableSmtc();
    _smtc?.dispose();
    _smtc = null;
    _initialized = false;
    _playerNotifier = null;
  }
}
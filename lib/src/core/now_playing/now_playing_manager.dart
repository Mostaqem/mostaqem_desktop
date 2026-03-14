import 'package:flutter/services.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';

/// Singleton class to manage macOS Now Playing integration
class NowPlayingManager {
  NowPlayingManager._();
  static final NowPlayingManager _instance = NowPlayingManager._();
  static NowPlayingManager get instance => _instance;

  static const _channel = MethodChannel('now_playing');
  static const _eventsChannel = MethodChannel('now_playing_events');

  bool _initialized = false;
  PlayerNotifier? _playerNotifier;

  Future<void> init(PlayerNotifier playerNotifier) async {
    if (_initialized) return;

    _playerNotifier = playerNotifier;

    _eventsChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onPlay':
          await _playerNotifier?.player.play();
        case 'onPause':
          await _playerNotifier?.player.pause();
        case 'onPlayPause':
          await _playerNotifier?.handlePlayPause();
        case 'onNext':
          await _playerNotifier?.playNext();
        case 'onPrevious':
          await _playerNotifier?.playPrevious();
        case 'onSeek':
          final positionMs = call.arguments as int;
          await _playerNotifier?.handleSeek(
            Duration(milliseconds: positionMs),
          );
      }
    });

    _initialized = true;
  }

  void updateMetadata({
    required String title,
    required String artist,
    Duration? duration,
    String? artworkUrl,
  }) {
    _channel.invokeMethod('updateMetadata', {
      'title': title,
      'artist': artist,
      if (duration != null) 'duration': duration.inMilliseconds,
      if (artworkUrl != null) 'artworkUrl': artworkUrl,
    });
  }

  void updatePlaybackState({required bool isPlaying}) {
    _channel.invokeMethod('updatePlaybackState', {
      'isPlaying': isPlaying,
    });
  }

  void updatePosition({
    required Duration position,
    required Duration duration,
  }) {
    _channel.invokeMethod('updatePosition', {
      'position': position.inMilliseconds,
      'duration': duration.inMilliseconds,
    });
  }
}

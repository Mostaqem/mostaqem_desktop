import 'package:media_kit/media_kit.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';

class AudioState {
  AudioState({
    this.isPlaying = false,
    this.position = Duration.zero,
    this.volume = 1.0,
    this.buffering = Duration.zero,
    this.loop = PlaylistMode.none,
    this.duration = Duration.zero,
    this.album,
  });
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final double volume;
  final PlaylistMode loop;
  final Duration buffering;
  final Album? album;

  AudioState copyWith({
    bool? isPlaying,
    Duration? position,
    PlaylistMode? loop,
    Duration? buffering,
    Duration? duration,
    Album? album,
    double? volume,
  }) {
    return AudioState(
      position: position ?? this.position,
      duration: duration ?? this.duration,
      volume: volume ?? this.volume,
      album: album ?? this.album,
      buffering: buffering ?? this.buffering,
      loop: loop ?? this.loop,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}

import 'package:media_kit/media_kit.dart';

class AudioState {
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final double volume;
  final PlaylistMode loop;
  final bool buffering;
  AudioState(
      {this.isPlaying = true,
      this.position = Duration.zero,
      this.volume = 1.0,
      this.buffering = false,
      this.loop = PlaylistMode.none,
      this.duration = Duration.zero});

  AudioState copyWith(
      {bool? isPlaying,
      Duration? position,
      PlaylistMode? loop,
      bool? buffering,
      Duration? duration,
      double? volume}) {
    return AudioState(
        position: position ?? this.position,
        duration: duration ?? this.duration,
        volume: volume ?? this.volume,
        buffering: buffering ?? this.buffering,
        loop: loop ?? this.loop,
        isPlaying: isPlaying ?? this.isPlaying);
  }
}

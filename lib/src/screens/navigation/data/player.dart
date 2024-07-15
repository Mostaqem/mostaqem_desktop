import 'package:media_kit/media_kit.dart';

class AudioState {
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final double volume;
  final PlaylistMode loop;
  final bool seeked;
  AudioState(
      {this.isPlaying = true,
      this.position = Duration.zero,
      this.volume = 1.0,
      this.seeked = false,
      this.loop = PlaylistMode.none,
      this.duration = Duration.zero});

  AudioState copyWith(
      {bool? isPlaying,
      Duration? position,
      PlaylistMode? loop,
      bool? seeked,
      Duration? duration,
      double? volume}) {
    return AudioState(
        position: position ?? this.position,
        duration: duration ?? this.duration,
        volume: volume ?? this.volume,
        seeked: seeked ?? this.seeked,
        loop: loop ?? this.loop,
        isPlaying: isPlaying ?? this.isPlaying);
  }
}

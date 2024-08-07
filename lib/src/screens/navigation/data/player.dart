import 'package:media_kit/media_kit.dart';

class AudioState {
  AudioState(
      {this.isPlaying = false,
      this.position = Duration.zero,
      this.volume = 1.0,
      this.buffering = Duration.zero,
      this.loop = PlaylistMode.none,
      this.duration = Duration.zero,});
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final double volume;
  final PlaylistMode loop;
  final Duration buffering;

  AudioState copyWith(
      {bool? isPlaying,
      Duration? position,
      PlaylistMode? loop,
      Duration? buffering,
      Duration? duration,
      double? volume,}) {
    return AudioState(
        position: position ?? this.position,
        duration: duration ?? this.duration,
        volume: volume ?? this.volume,
        buffering: buffering ?? this.buffering,
        loop: loop ?? this.loop,
        isPlaying: isPlaying ?? this.isPlaying,);
  }
}

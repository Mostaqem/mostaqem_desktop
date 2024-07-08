enum LoopMode { none, single, repeat }

class AudioState {
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final double volume;
  final LoopMode loop;
  AudioState(
      {this.isPlaying = true,
      this.position = Duration.zero,
      this.volume = 1.0,
      this.loop = LoopMode.none,
      this.duration = Duration.zero});

  AudioState copyWith(
      {bool? isPlaying,
      Duration? position,
      LoopMode? loop,
      Duration? duration,
      double? volume}) {
    return AudioState(
        position: position ?? this.position,
        duration: duration ?? this.duration,
        volume: volume ?? this.volume,
        loop: loop ?? this.loop,
        isPlaying: isPlaying ?? this.isPlaying);
  }
}

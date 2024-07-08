class AudioState {
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final double volume;
  AudioState(
      {this.isPlaying = true,
      this.position = Duration.zero,
      this.volume = 1.0,
      this.duration = Duration.zero});

  AudioState copyWith(
      {bool? isPlaying,
      Duration? position,
      Duration? duration,
      double? volume}) {
    return AudioState(
        position: position ?? this.position,
        duration: duration ?? this.duration,
        volume: volume ?? this.volume,
        isPlaying: isPlaying ?? this.isPlaying);
  }
}

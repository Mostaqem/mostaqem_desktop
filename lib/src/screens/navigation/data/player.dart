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
    this.nextAlbum,
    this.isShuffle = false,
    this.queue = const [],
    this.queueIndex,
    this.broadcastName,
  });
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final double volume;
  final PlaylistMode loop;
  final Duration buffering;
  final Album? album;
  final int? queueIndex;
  final List<Album> queue;
  final Album? nextAlbum;
  final bool isShuffle;
  final String? broadcastName;

  AudioState copyWith({
    bool? isPlaying,
    Duration? position,
    List<Album>? queue,
    PlaylistMode? loop,
    Album? nextAlbum,
    Duration? buffering,
    Duration? duration,
    Album? album,
    String? broadcastName,
    double? volume,
    bool? isShuffle,
    int? queueIndex,
  }) {
    return AudioState(
      position: position ?? this.position,
      duration: duration ?? this.duration,
      volume: volume ?? this.volume,
      album: album ?? this.album,
      isShuffle: isShuffle ?? this.isShuffle,
      queue: queue ?? this.queue,
      broadcastName: broadcastName ?? this.broadcastName,
      queueIndex: queueIndex ?? this.queueIndex,
      nextAlbum: nextAlbum ?? this.nextAlbum,
      buffering: buffering ?? this.buffering,
      loop: loop ?? this.loop,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

}

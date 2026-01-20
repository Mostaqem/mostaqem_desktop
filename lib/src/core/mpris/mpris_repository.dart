import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mpris_service/mpris_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mpris_repository.g.dart';

class MPRISRepository {
  MPRISRepository(this.ref);
  final Ref ref;

  Future<MPRIS> init() async {
    final instance = await MPRIS.create(
      busName: 'org.mpris.MediaPlayer2.mostaqem',
      identity: 'Mostaqem',
      desktopEntry: '/usr/share/applications/mostaqem',
    );
    return instance;
  }

  Future<void> createMetadata({
    required String reciterName,
    required String surah,
    required String image,
    required String url,
    required Duration position,
  }) async {
    final instance = await init();
    instance
      ..metadata = MPRISMetadata(
        Uri.parse(url),
        length: position,
        artUrl: Uri.parse(image),
        artist: [reciterName],
        title: surah,
      )
      ..setEventHandler(
        MPRISEventHandler(
          seek: (offset) async {
            await ref.read(playerProvider.notifier).handleSeek(offset);
          },
          volume: (value) async {
            await ref.read(playerProvider.notifier).handleVolume(value);
          },
          playPause: () async {
            if (ref.read(playerProvider).isPlaying) {
              instance.playbackStatus = MPRISPlaybackStatus.playing;
            } else {
              instance.playbackStatus = MPRISPlaybackStatus.paused;
            }
          },
          play: () async {
            instance.playbackStatus = MPRISPlaybackStatus.playing;
            await ref.read(playerProvider.notifier).player.play();
          },
          pause: () async {
            instance.playbackStatus = MPRISPlaybackStatus.paused;

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
  }
}

@riverpod
MPRISRepository mprisRepository(Ref ref) {
  return MPRISRepository(ref);
}

@riverpod
Future<void> createMetadata(
  Ref ref, {
  required String reciterName,
  required String surah,
  required String image,
  required String url,
  required Duration position,
}) async {
  final instance = await ref.watch(mprisRepositoryProvider).init();
  instance
    ..metadata = MPRISMetadata(
      Uri.parse(url),
      length: position,
      artUrl: Uri.parse(image),
      artist: [reciterName],
      title: surah,
    )
    ..setEventHandler(
      MPRISEventHandler(
        seek: (offset) async {
          await ref.read(playerProvider.notifier).handleSeek(offset);
        },
        volume: (value) async {
          await ref.read(playerProvider.notifier).handleVolume(value);
        },
        playPause: () async {
          if (ref.read(playerProvider).isPlaying) {
            instance.playbackStatus = MPRISPlaybackStatus.playing;
          } else {
            instance.playbackStatus = MPRISPlaybackStatus.paused;
          }
        },
        play: () async {
          instance.playbackStatus = MPRISPlaybackStatus.playing;
          await ref.read(playerProvider.notifier).player.play();
        },
        pause: () async {
          instance.playbackStatus = MPRISPlaybackStatus.paused;

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
}

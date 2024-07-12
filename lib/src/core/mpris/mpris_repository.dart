import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mpris_service/mpris_service.dart';

final mprisRepositoryProvider = Provider(MPRISRepository.new);

class MPRISRepository {
  final Ref ref;
  MPRISRepository(this.ref);
  Future<MPRIS> init() async {
    final instance = await MPRIS.create(
      busName: 'org.mpris.MediaPlayer2.mostaqem',
      identity: 'Mostaqem',
      desktopEntry: '/usr/share/applications/mostaqem',
    );
    return instance;
  }

  Future<void> createMetadata(
      {required String reciterName,
      required String surah,
      required String image,
      required String url,
      required Duration position}) async {
    final instance = await init();
    instance.metadata = MPRISMetadata(
      Uri.parse(url),
      length: position,
      artUrl: Uri.parse(
        image,
      ),
      artist: [reciterName],
      title: surah,
    );

    instance.setEventHandler(
      MPRISEventHandler(
        playPause: () async {
          if (ref.read(playerNotifierProvider).isPlaying) {
            instance.playbackStatus = MPRISPlaybackStatus.playing;
          } else {
            instance.playbackStatus = MPRISPlaybackStatus.paused;
          }
        },
        play: () async {
          instance.playbackStatus = MPRISPlaybackStatus.playing;
          ref.read(playerNotifierProvider.notifier).player.play();
        },
        pause: () async {
          instance.playbackStatus = MPRISPlaybackStatus.paused;

          ref.read(playerNotifierProvider.notifier).player.pause();
        },
        next: () async {
          print('Next');
        },
        previous: () async {
          print('Previous');
        },
      ),
    );
  }
}

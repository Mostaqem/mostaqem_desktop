import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/player_widget.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';
import 'package:mostaqem/src/screens/settings/providers/download_cache.dart';

class OfflineRepository {
  OfflineRepository(this.ref);
  final Ref ref;

  Stream<FileSystemEntity> getLocalAudio() async* {
    final downloadPath = ref.watch(downloadDestinationProvider).requireValue;
    final audioFiles = <FileSystemEntity>[];
    final path = downloadPath;
    final dir = Directory(path);
    final files = dir.list(recursive: true);
    await for (final file in files) {
      final ext = file.path.split('.').last;
      if (ext.contains('mp3')) {
        audioFiles.add(file);
      }
    }
    yield* Stream.fromIterable(audioFiles);
  }

  Stream<List<Album>> loadAudioAsAlbum() async* {
    final albums = <Album>[];
    final localAudios = getLocalAudio();
    await for (final audio in localAudios) {
      final metadata = await MetadataGod.readMetadata(file: audio.path);
      if (metadata.title != null) {
        final album = Album(
          recitationID: 0,
          surah: Surah(
            id: 1,
            simpleName: '',
            arabicName: metadata.title ?? '',
            revelationPlace: '',
          ),
          reciter: Reciter(
            id: 1,
            englishName: '',
            arabicName: metadata.artist ?? '',
          ),
          url: audio.path,
        );

        albums.add(album);
      }
    }

    yield albums;
  }

  Stream<bool> isAudioDownloaded() async* {
    final album = ref.watch(playerSurahProvider);
    if (album == null) {
      yield false;
      return;
    }

    final localAudios = loadAudioAsAlbum();

    await for (final audios in localAudios) {
      final downloadedAlbums = audios.map((audio) => audio).toSet();
      if (downloadedAlbums.contains(album)) {
        yield true;
        return;
      }
    }

    yield false;
  }
}

final offlineRepo = Provider(OfflineRepository.new);

final getLocalAudioProvider =
    StreamProvider.autoDispose<List<Album>>((ref) async* {
  final repo = ref.watch(offlineRepo);
  yield* repo.loadAudioAsAlbum();
});

final isAudioDownloaded = StreamProvider.autoDispose<bool>((ref) async* {
  final repo = ref.watch(offlineRepo);
  yield* repo.isAudioDownloaded();
});

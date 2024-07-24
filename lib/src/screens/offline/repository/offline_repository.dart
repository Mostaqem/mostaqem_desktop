import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';

import '../../settings/providers/download_cache.dart';

class OfflineRepository {
  final Ref ref;
  OfflineRepository(this.ref);
  final controller = StreamController<List<Album>>();

  Stream<FileSystemEntity> getLocalAudio() async* {
    final downloadPath = ref.watch(downloadDestinationProvider).requireValue;
    List<FileSystemEntity> audioFiles = [];
    final path = downloadPath;
    final dir = Directory(path);
    final files = dir.list(recursive: true);
    await for (final file in files) {
      final ext = file.path.split('.').last;
      if (ext.contains("mp3")) {
        audioFiles.add(file);
      }
    }
    yield* Stream.fromIterable(audioFiles);
  }

  Stream<List<Album>> loadAudioAsAlbum() async* {
    final List<Album> albums = [];
    final localAudios = getLocalAudio();
    await for (final audio in localAudios) {
      final metadata = await MetadataGod.readMetadata(file: audio.path);
      if (metadata.title != null) {
        final album = Album(
            surah: Surah(
                id: 1,
                simpleName: "",
                arabicName: metadata.title ?? "",
                revelationPlace: ""),
            reciter: Reciter(
                id: 1, englishName: "", arabicName: metadata.artist ?? ""),
            url: audio.path);

        albums.add(album);
      }
    }

    yield albums;
  }
}

final offlineRepo = Provider(OfflineRepository.new);

final getLocalAudioProvider =
    StreamProvider.autoDispose<List<Album>>((ref) async* {
  final repo = ref.watch(offlineRepo);
  yield* repo.loadAudioAsAlbum();
});

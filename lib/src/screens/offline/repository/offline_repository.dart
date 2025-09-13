import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/offline/repository/metadata_repository.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';
import 'package:mostaqem/src/screens/settings/providers/download_cache.dart';

class OfflineRepository {
  OfflineRepository(this.ref);
  final Ref ref;
  final metadataRepository = FfiMetadataRepository();

  Stream<FileSystemEntity> getLocalAudio() async* {
    final downloadPath = await ref.watch(downloadDestinationProvider.future);
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

  Future<List<int>> getDownloadsFiles() async {
    final filenames = <int>[];
    final downloadPath = await ref.watch(downloadDestinationProvider.future);

    final directory = Directory(downloadPath);
    final files = directory.listSync();
    for (final file in files) {
      if (Platform.isWindows) {
        final filename = file.path.split(r'\').last.split('.').first;
        if (int.tryParse(filename) != null) filenames.add(int.parse(filename));
      } else if (Platform.isLinux) {
        final filename = file.path.split('/').last.split('.').first;
        if (int.tryParse(filename) != null) filenames.add(int.parse(filename));
      }
    }
    return filenames;
  }

  Stream<List<Album>> loadAudioAsAlbum() async* {
    final albums = <Album>[];
    final localAudios = getLocalAudio();
    await for (final audio in localAudios) {
      final metadata = await metadataRepository.getMetadata(audio.path);
      final album = Album(
        recitationID: 0,
        surah: Surah(
          id: int.tryParse(metadata.getGenre() ?? '0') ?? 0,
          simpleName: '',
          arabicName: metadata.getTitle() ?? '',
          revelationPlace: '',
        ),
        reciter: Reciter(
          id: 1,
          englishName: '',
          arabicName: metadata.getArtist() ?? '',
        ),
        url: audio.path,
        isLocal: true,
      );

      albums.add(album);
    }

    yield albums;
  }
}

final offlineRepo = Provider(OfflineRepository.new);

final getLocalAudioProvider = StreamProvider.autoDispose<List<Album>>((
  ref,
) async* {
  final repo = ref.watch(offlineRepo);
  yield* repo.loadAudioAsAlbum();
});

final isAudioDownloaded = FutureProvider.autoDispose<bool>((ref) async {
  final repo = ref.watch(offlineRepo);

  final localAudios = await repo.getDownloadsFiles();
  final player = ref.watch(currentAlbumProvider);
  final recitationID = player?.recitationID ?? 0;
  final surahID = player?.surah.id ?? 0;
  final downloadedSurah = recitationID + surahID;
  if (localAudios.contains(downloadedSurah)) {
    return true;
  }
  return false;
});

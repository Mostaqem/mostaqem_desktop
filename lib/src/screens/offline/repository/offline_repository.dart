import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';
import 'package:mostaqem/src/screens/settings/providers/download_cache.dart';

class OfflineRepository {
  OfflineRepository(this.ref);
  final Ref ref;

  Stream<FileSystemEntity> getLocalAudio() async* {
    final downloadPath = await ref.watch(downloadDestinationProvider.future);
    final audioFiles = <FileSystemEntity>[];
    final path = downloadPath!;
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

    final directory = Directory(downloadPath!);

    // ✅ Check if directory exists
    if (!await directory.exists()) {
      // Option A: return empty list

      // Option B: reset to default folder
      return [];
    }

    try {
      final files = directory.listSync();
      for (final file in files) {
        final filename = Platform.isWindows
            ? file.path.split(r'\').last.split('.').first
            : file.path.split('/').last.split('.').first;

        final id = int.tryParse(filename);
        if (id != null) filenames.add(id);
      }
    } catch (e) {
      // fallback if something unexpected goes wrong
      debugPrint('Error reading downloads folder: $e');
    }

    return filenames;
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
            id: metadata.discNumber ?? 0,
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
          isLocal: true,
        );

        albums.add(album);
      }
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

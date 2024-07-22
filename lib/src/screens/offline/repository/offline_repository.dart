import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';
import 'package:path_provider/path_provider.dart';

class OfflineRepository {
  Future<List<FileSystemEntity>> getLocalAudio() async {
    final directory = await getDownloadsDirectory();

    if (directory != null) {
      final path = directory.path;
      final dir = Directory(path);
      final files = dir.listSync();

      final audioFiles = files.where((file) {
        final ext = file.path.split(".").last;
        return ["mp3"].contains(ext);
      }).toList();

      return audioFiles;
    }
    return [];
  }

  Future<List<Album>> loadAudioAsAlbum() async {
    final files = await getLocalAudio();
    final List<Album> albums = [];
    for (var i = 0; i < files.length; i++) {
      final metadata = await MetadataGod.readMetadata(file: files[i].path);
      if (metadata.title != null) {
        final album = Album(
            surah: Surah(
                id: 1,
                simpleName: "",
                arabicName: metadata.title ?? "",
                revelationPlace: ""),
            reciter: Reciter(
                id: 1, englishName: "", arabicName: metadata.artist ?? ""),
            url: files[i].path);

        albums.add(album);
      }
    }
    return albums;
  }
}

final getLocalAudioProvider = FutureProvider<List<Album>>((ref) async {
  return await OfflineRepository().loadAudioAsAlbum();
});

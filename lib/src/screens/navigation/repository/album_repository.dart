import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_cache.dart';
import 'package:mostaqem/src/screens/reciters/providers/reciters_repository.dart';

class AlbumRepository {
  AlbumRepository(this.ref);
  final Ref ref;

  String createShortHash(int surahID, int? recitationID, int reciterID) {
    final uniqueData = 'surahID_${surahID}_${recitationID ?? 0},$reciterID';
    final hash = sha256.convert(utf8.encode(uniqueData)).toString();
    return hash.substring(0, 8);
  }

  Future<Album> fetchPlayerAlbum({
    required int surahID,
    required int reciterID,
    int? recitationID,
  }) async {
    final surah = await ref.read(fetchChapterByIdProvider(id: surahID).future);
    final reciter = await ref.read(fetchReciterProvider(id: reciterID).future);
    final mixID = createShortHash(surahID, recitationID, reciter.id);

    final audio = await ref.read(
      fetchAudioForChapterProvider(
        chapterNumber: surahID,
        reciterID: reciterID,
        recitationID: recitationID,
      ).future,
    );
    final album = Album(
      surah: surah,
      reciter: reciter,
      url: audio.url,
      recitationID: audio.recitationID,
    );
    await ref
        .read(playerCacheProvider(key: mixID).notifier)
        .setAlbum(album, key: mixID);

    return album;
  }
}

final albumRepositoryProvider = Provider<AlbumRepository>(AlbumRepository.new);

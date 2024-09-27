import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lrc/lrc.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/navigation/repository/lyrics.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lyrics_repository.g.dart';

@riverpod
Future<String?> getLyrics(GetLyricsRef ref, {required String filename}) async {
  final directory = await getTemporaryDirectory();
  final cacheDir = directory.path;
  final file = File('$cacheDir/$filename.lrc');
  if (file.existsSync() && file.lengthSync() > 0) {
    return file.readAsString();
  }
  final player = ref.read(currentAlbumProvider);

  final lyrics = await ref.read(
    fetchSurahLyricsProvider(
      surahID: player!.surah.id,
      recitationID: player.recitationID,
    ).future,
  );

  if (lyrics == null || lyrics.isEmpty) {
    return null;
  }

  await ref
      .read(cacheLyricsProvider(filename: filename, content: lyrics).future);

  return lyrics;
}

@riverpod
Future<File> cacheLyrics(
  CacheLyricsRef ref, {
  required String filename,
  required String content,
}) async {
  final directory = await getTemporaryDirectory();
  final cacheDir = directory.path;
  final file = File('$cacheDir/$filename.lrc');

  return file.writeAsString(content);
}

@riverpod
Future<({int currentIndex, List<Lyrics> lyricsList})?> syncLyrics(
  SyncLyricsRef ref,
) async {
  final currentAlbum = ref.watch(currentAlbumProvider);
  final fileName =
      '${(currentAlbum?.surah.id ?? 0) + (currentAlbum?.recitationID ?? 0) + (currentAlbum?.reciter.id ?? 1)}';
  debugPrint('Lyrics: $fileName');

  final lyrics = await ref.read(getLyricsProvider(filename: fileName).future);
  if (lyrics == null) {
    return null;
  }

  final current = <Lyrics>[];
  final currentLyricsAveragedMap = <int, String>{};
  if (Lrc.isValid(lyrics)) {
    current.addAll(
      Lrc.parse(lyrics).lyrics.map(
            (e) => Lyrics(time: e.timestamp.inMilliseconds, words: e.lyrics),
          ),
    );
    for (final lyric in current) {
      currentLyricsAveragedMap[lyric.time] = lyric.words;
    }

    ref.listen(
      playerNotifierProvider.select((player) => player.position),
      (previous, next) {
        for (var i = 0; i < currentLyricsAveragedMap.entries.length; i++) {
          final lyric = currentLyricsAveragedMap.entries.elementAt(i);
          if (lyric.key <= next.inMilliseconds) {
            ref
                .read(currentLyricsNotifierProvider.notifier)
                .updateLyrics(value: (currentIndex: i, lyricsList: current));
          }
        }
      },
    );
  }
  return null;
}

@riverpod
class CurrentLyricsNotifier extends _$CurrentLyricsNotifier {
  @override
  Future<({int currentIndex, List<Lyrics> lyricsList})?> build() async {
    return ref.watch(syncLyricsProvider.future);
  }

  void updateLyrics({
    required ({int currentIndex, List<Lyrics> lyricsList}) value,
  }) {
    state = AsyncData(value);
  }
}

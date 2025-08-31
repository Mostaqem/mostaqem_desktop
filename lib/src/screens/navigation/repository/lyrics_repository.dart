// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lrc/lrc.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/navigation/repository/lyrics.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lyrics_repository.g.dart';

@riverpod
Future<String?> getLyrics(Ref ref, {required String filename}) async {
  final directory = await getTemporaryDirectory();
  final cacheDir = directory.path;
  final file = File('$cacheDir/$filename.lrc');
  if (file.existsSync() && file.lengthSync() > 0) {
    debugPrint('File: $file');
    return file.readAsString();
  }
  final player = ref.watch(currentAlbumProvider);

  final lyrics = await ref.read(
    fetchSurahLyricsProvider(
      surahID: player!.surah.id,
      recitationID: player.recitationID,
    ).future,
  );

  if (lyrics == null || lyrics.isEmpty) {
    return null;
  }
  final adjustedLyrics = lyrics.replaceAll('/', '\n');
  await ref.read(
    cacheLyricsProvider(filename: filename, content: adjustedLyrics).future,
  );

  return adjustedLyrics;
}

@riverpod
Future<File> cacheLyrics(
  Ref ref, {
  required String filename,
  required String content,
}) async {
  final directory = await getTemporaryDirectory();
  final cacheDir = directory.path;
  final file = File('$cacheDir/$filename.lrc');

  return file.writeAsString(content);
}

@riverpod
Future<String?> syncLyrics(Ref ref) async {
  final currentAlbum = ref.watch(currentAlbumProvider);
  final fileName =
      'surah_${currentAlbum?.surah.id}_recitation_${currentAlbum?.recitationID}';
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

    ref.listen(playerNotifierProvider.select((player) => player.position), (
      _,
      next,
    ) {
      for (var i = 0; i < currentLyricsAveragedMap.entries.length; i++) {
        final lyric = currentLyricsAveragedMap.entries.elementAt(i);
        if (lyric.key <= next.inMilliseconds) {
          ref
              .read(currentLyricsNotifierProvider.notifier)
              .updateLyrics(value: lyric.value);
        }
      }
    });
  }
  return null;
}

@riverpod
class CurrentLyricsNotifier extends _$CurrentLyricsNotifier {
  @override
  Future<String?> build() async {
    return ref.watch(syncLyricsProvider.future);
  }

  void updateLyrics({required String value}) {
    state = AsyncData(value);
  }
}

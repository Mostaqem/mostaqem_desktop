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
  print('cacheDir: $cacheDir');

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
  print('lyrics1: $lyrics');

  if (lyrics == null || lyrics.isEmpty) {
    return null;
  }
  final adjustedLyrics = lyrics.replaceAll('/', '\n');

  print('lyrics1.5: $lyrics');

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

/// Provides parsed lyrics for the current album
@Riverpod(keepAlive: true)
Future<List<Lyrics>?> parsedLyrics(Ref ref) async {
  final currentAlbum = ref.watch(currentAlbumProvider);
  if (currentAlbum == null) return null;

  final fileName =
      'surah_${currentAlbum.surah.id}_recitation_${currentAlbum.recitationID}';

  final lyricsString = await ref.watch(
    getLyricsProvider(filename: fileName).future,
  );

  if (lyricsString == null || !Lrc.isValid(lyricsString)) {
    return null;
  }

  debugPrint('Parsed lyrics for: $fileName');

  return Lrc.parse(lyricsString).lyrics
      .map((e) => Lyrics(time: e.timestamp.inMilliseconds, words: e.lyrics))
      .toList();
}

/// Finds the current lyric based on playback position using binary search
int _findCurrentLyricIndex(List<Lyrics> lyrics, int positionMs) {
  if (lyrics.isEmpty) return -1;

  // Binary search for efficiency O(log n)
  var left = 0;
  var right = lyrics.length - 1;
  var result = -1;

  while (left <= right) {
    final mid = left + (right - left) ~/ 2;

    if (lyrics[mid].time <= positionMs) {
      result = mid;
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }

  return result;
}

/// Provides the current lyric text based on playback position
@riverpod
class CurrentLyric extends _$CurrentLyric {
  @override
  String? build() {
    final lyrics = ref.watch(parsedLyricsProvider).value;
    if (lyrics == null || lyrics.isEmpty) return null;

    final position = ref.watch(playerProvider.select((p) => p.position));
    final positionMs = position.inMilliseconds;

    final currentIndex = _findCurrentLyricIndex(lyrics, positionMs);

    if (currentIndex == -1) return null;

    return lyrics[currentIndex].words;
  }
}

/// Provides the index of the current lyric line
@Riverpod(keepAlive: true)
class CurrentLyricIndex extends _$CurrentLyricIndex {
  @override
  int build() {
    final lyrics = ref.watch(parsedLyricsProvider).value;
    if (lyrics == null || lyrics.isEmpty) return -1;

    final position = ref.watch(playerProvider.select((p) => p.position));
    final positionMs = position.inMilliseconds;

    return _findCurrentLyricIndex(lyrics, positionMs);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lrc/lrc.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/navigation/repository/lyrics.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tuple/tuple.dart';
part 'lyrics_repository.g.dart';

@riverpod
Stream<Tuple2<int, List<Lyrics>>> syncLyrics(SyncLyricsRef ref) async* {
  final surahAudio = await ref.read(
    fetchAudioForChapterProvider(chapterNumber: 1, recitationID: 161).future,
  );
  final lyrics = surahAudio.item3;

  if (lyrics == null) {
    return;
  }
  final current = <Lyrics>[];
  final currentLyricsAveragedMap = <int, String>{};

  if (Lrc.isValid(lyrics)) {
    debugPrint('Lyrics is valid: ${Lrc.parse(lyrics)}');
    current.addAll(
      Lrc.parse(lyrics).lyrics.map(
            (e) => Lyrics(time: e.timestamp.inMilliseconds, words: e.lyrics),
          ),
    );
    debugPrint('current: $current');

    for (final lyric in current) {
      currentLyricsAveragedMap[lyric.time ~/ 1000] = lyric.words;
    }
    debugPrint('currentMap: $currentLyricsAveragedMap');

    while (true) {
      var currentIndex = -1;
      for (var i = 0; i < currentLyricsAveragedMap.entries.length; i++) {
        ref.listen(playerNotifierProvider, (_, n) {
          final lyric = currentLyricsAveragedMap.entries.elementAt(i);
          if (lyric.key == n.position.inMilliseconds ~/ 1000) {
            currentIndex = i;
          }
        });
      }
      if (currentIndex != -1) {
        debugPrint('CurrentIndex: $currentIndex, Current: $current');

        yield Tuple2(currentIndex, current);
      }
      await Future.delayed(
        const Duration(milliseconds: 500),
      ); // Adjust delay as needed
    }
  }
}

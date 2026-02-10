import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/navigation/repository/lyrics.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/reading/data/script.dart';
import 'package:mostaqem/src/screens/reading/providers/reading_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lyrics_repository.g.dart';

/// Provides parsed ayah timings for the current album
@Riverpod(keepAlive: true)
Future<List<AyahTiming>?> parsedAyahTimings(Ref ref) async {
  final currentAlbum = ref.watch(currentAlbumProvider);
  if (currentAlbum == null) return null;

  final timings = await ref.watch(
    fetchAyahTimingProvider(
      surahID: currentAlbum.surah.id,
      reciterID: currentAlbum.reciter.id,
    ).future,
  );

  print('Got Timings: $timings');

  // Filter out ayah=0 (بسم الله) since it has no matching script entry.
  // Only filter if ayah=0 exists — some reciters don't include it.
  final filtered = timings.where((t) => t.ayah > 0).toList();
  return filtered.isNotEmpty ? filtered : timings;
}

/// Provides all ayah scripts for the current surah
@Riverpod(keepAlive: true)
Future<List<Script>?> surahScripts(Ref ref) async {
  final currentAlbum = ref.watch(currentAlbumProvider);
  if (currentAlbum == null) return null;

  return ref.watch(fetchQuranProvider(surahID: currentAlbum.surah.id).future);
}

/// Finds the current ayah index based on playback position using binary search.
/// Uses only startTime — the ayah stays highlighted until the next one starts.
int _findCurrentAyahIndex(List<AyahTiming> timings, int positionMs) {
  if (timings.isEmpty) return -1;

  var left = 0;
  var right = timings.length - 1;
  var result = -1;

  while (left <= right) {
    final mid = left + (right - left) ~/ 2;

    if (timings[mid].startTime <= positionMs) {
      result = mid;
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }

  return result;
}

/// Provides the ayah number of the currently playing ayah.
/// Returns -1 if no ayah is currently active.
@Riverpod(keepAlive: true)
class CurrentAyahIndex extends _$CurrentAyahIndex {
  int _lastLoggedAyah = -1;

  @override
  int build() {
    final timings = ref.watch(parsedAyahTimingsProvider).value;
    if (timings == null || timings.isEmpty) return -1;

    final currentAlbum = ref.watch(currentAlbumProvider);
    final position = ref.watch(playerProvider.select((p) => p.position));
    final positionMs = position.inMilliseconds;
    final idx = _findCurrentAyahIndex(timings, positionMs);
    if (idx < 0) return -1;

    final ayah = timings[idx];
    final nextAyah = idx + 1 < timings.length ? timings[idx + 1] : null;

    // Only log when ayah changes to avoid spamming
    if (ayah.ayah != _lastLoggedAyah) {
      _lastLoggedAyah = ayah.ayah;
      final delta = positionMs - ayah.startTime;
      debugPrint(
        '[LyricsDebug] '
        'Reciter: ${currentAlbum?.reciter.name ?? "?"} '
        '(ID: ${currentAlbum?.reciter.id ?? "?"}) | '
        'Ayah: #${ayah.ayah} | '
        'Highlighted: YES | '
        'PlayerPos: ${positionMs}ms | '
        'AyahStart: ${ayah.startTime}ms | '
        'AyahEnd: ${ayah.endTime}ms | '
        'NextStart: ${nextAyah?.startTime ?? "N/A"}ms | '
        'Delta(pos-start): ${delta}ms',
      );
    }

    return ayah.ayah;
  }
}

@riverpod
class CurrentAyah extends _$CurrentAyah {
  @override
  Script? build() {
    final scripts = ref.watch(surahScriptsProvider).value;
    if (scripts == null || scripts.isEmpty) return null;

    final ayahNumber = ref.watch(currentAyahIndexProvider);
    if (ayahNumber < 0) return null;

    return scripts.firstWhere(
      (s) => s.verseNumber == ayahNumber,
      orElse: () => scripts.first,
    );
  }
}

// ignore_for_file: avoid_dynamic_calls, inference_failure_on_untyped_parameter

import 'package:flutter/material.dart';
import 'package:mostaqem/src/core/dio/apis.dart';
import 'package:mostaqem/src/core/dio/dio_helper.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/offline/repository/offline_repository.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';
import 'package:mostaqem/src/screens/reciters/providers/default_reciter.dart';
import 'package:mostaqem/src/screens/reciters/providers/reciters_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_providers.g.dart';

/// Fetches all the chapters
@Riverpod(keepAlive: true)
Future<List<Surah>> fetchAllChapters(Ref ref) async {
  final response = await ref
      .read(dioHelperProvider)
      .getHTTP('/suwar', baseAPI: APIs.mp3QuranAPI);

  final surahs = response.data['suwar']
      .map<Surah>((e) => Surah.fromJson(e as Map<String, Object?>))
      .toList();

  return surahs;
}

@riverpod
Future<List<Surah>> searchChapters(Ref ref, {String? query}) async {
  final surahs = await ref.read(fetchAllChaptersProvider.future);
  if (query == null || query.isEmpty) {
    return surahs;
  }
  final existingSurahs = surahs
      .where((surah) => surah.name.toLowerCase().contains(query.toLowerCase()))
      .toList();

  return existingSurahs;
}

/// Fetches chapter by [id]
@riverpod
Future<Surah> fetchChapterById(Ref ref, {required int id}) async {
  final surahs = await ref.read(fetchAllChaptersProvider.future);
  final existingSurah = surahs.where((surah) => surah.id == id).single;

  return existingSurah;
}

/// Fetches audio for chapter by [chapterNumber] and [reciterID]
@riverpod
Future<({String url, int recitationID})> fetchAudioForChapter(
  Ref ref, {
  required int chapterNumber,
  Reciter? reciter,
  int? recitationID,
}) async {
  final defaultReciter = ref.watch(defaultReciterProvider);
  var effectiveReciter = reciter ?? defaultReciter;

  // If moshaf is empty, fetch full reciter data from API
  if (effectiveReciter.moshaf.isEmpty) {
    effectiveReciter = await ref.read(
      fetchReciterProvider(id: effectiveReciter.id).future,
    );
  }

  final surahNumber = surahIdTo3Digits(chapterNumber);

  final moshaf = effectiveReciter.moshaf.firstWhere(
    (m) => m.id == recitationID,
    orElse: () => effectiveReciter.moshaf.first,
  );

  final url = '${moshaf.server}$surahNumber.mp3';

  return (url: url, recitationID: moshaf.id);
}

@Riverpod(keepAlive: true)
Future<Album> fetchAlbum(
  Ref ref, {
  required int chapterNumber,
  int? recitationID,
  Reciter? reciter,
}) async {
  final Reciter effectiveReciter = reciter ?? ref.watch(defaultReciterProvider);

  final audio = await ref.read(
    fetchAudioForChapterProvider(
      chapterNumber: chapterNumber,
      reciter: effectiveReciter,
      recitationID: recitationID,
    ).future,
  );

  final surah = await ref.read(
    fetchChapterByIdProvider(id: chapterNumber).future,
  );

  return Album(
    surah: surah,
    reciter: effectiveReciter,
    url: audio.url,
    recitationID: audio.recitationID,
  );
}

/// Fetches the next chapter
@riverpod
Future<Surah?> fetchNextSurah(Ref ref) async {
  final isLocalAudio = ref.watch(isLocalProvider);
  if (isLocalAudio) {
    final currentPlayer = ref.watch(currentAlbumProvider);
    final audios = ref.read(getLocalAudioProvider).value;
    final currentIndex = audios!.indexWhere((e) => e == currentPlayer);
    if (currentIndex == audios.length - 1) {
      return null;
    }
    return audios[currentIndex + 1].surah;
  }
  final currentSurahID = ref.watch(currentSurahProvider)!.id;
  if (currentSurahID < 113) {
    return await ref.read(
      fetchChapterByIdProvider(id: currentSurahID + 1).future,
    );
  }
  return await ref.read(fetchChapterByIdProvider(id: 1).future);
}

/// Fetches random image from Unsplash API
@Riverpod(keepAlive: true)
Future<String> fetchRandomImage(Ref ref) async {
  final request = await ref.watch(dioHelperProvider).getHTTP('/image/random');
  return request.data['data'];
}

@riverpod
Future<String?> fetchSurahLyrics(
  Ref ref, {
  required int surahID,
  required int recitationID,
}) async {
  final request = await ref
      .watch(dioHelperProvider)
      .getHTTP('/audio/lrc?surah_id=$surahID&tilawa_id=$recitationID');
  return request.data?['data']?['lrc_content'];
}

@riverpod
Future<List<Surah>> fetchRandomSurahs(
  Ref ref, {
  required int limit,
  int? reciterID,
}) async {
  final response = await ref
      .read(dioHelperProvider)
      .getHTTP('/audio/random?limit=$limit}');

  return response.data['data']
      .map<Surah>((e) => Surah.fromJson(e['surah'] as Map<String, Object?>))
      .toList();
}

@riverpod
Future<Color?> getImageColor(Ref ref) async {
  if (!isProduction) return null;
  final imageUrl = await ref.watch(fetchRandomImageProvider.future);
  final scheme = await ColorScheme.fromImageProvider(
    provider: NetworkImage(imageUrl),
    brightness: Brightness.dark,
  );
  return scheme.primary;
}

@riverpod
class ShowControls extends _$ShowControls {
  @override
  bool build() {
    return true;
  }

  void show() => state = true;
  void hide() => state = false;
}

String surahIdTo3Digits(int id) {
  return id.toString().padLeft(3, '0');
}

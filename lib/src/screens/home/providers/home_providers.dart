// ignore_for_file: avoid_dynamic_calls, inference_failure_on_untyped_parameter

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/dio/dio_helper.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/offline/repository/offline_repository.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';
import 'package:mostaqem/src/screens/reciters/providers/default_reciter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_providers.g.dart';

/// Fetches all the chapters
@Riverpod(keepAlive: true)
Future<List<Surah>> fetchAllChapters(
  Ref ref, {
  required int page,
  int take = 30,
  String? query,
}) async {
  final url = query == null
      ? '/surah?page=$page&take=$take'
      : '/surah?page=$page&take=$take&name=$query';
  final response = await ref.read(dioHelperProvider).getHTTP(url);

  return response.data['data']['surah']
      .map<Surah>((e) => Surah.fromJson(e as Map<String, Object?>))
      .toList();
}

/// Fetches chapter by [id]
@riverpod
Future<Surah> fetchChapterById(Ref ref, {required int id}) async {
  final response = await ref.read(dioHelperProvider).getHTTP('/surah/$id');
  return Surah.fromJson(response.data['data'] as Map<String, dynamic>);
}

/// Fetches audio for chapter by [chapterNumber] and [reciterID]
@riverpod
Future<({String url, int recitationID})> fetchAudioForChapter(
  Ref ref, {
  required int chapterNumber,
  int? recitationID,
  int? reciterID,
}) async {
  final defaultReciterID = ref.watch(defaultReciterProvider).id;
  final playReciterId = reciterID ?? defaultReciterID;
  final url = recitationID == null
      ? '/audio/?reciter_id=$playReciterId&surah_id=$chapterNumber'
      : '/audio/?tilawa_id=$recitationID&surah_id=$chapterNumber';
  final response = await ref.read(dioHelperProvider).getHTTP(url);

  final audioURL = response.data['data']['url'] as String;
  final audioRecitationID = response.data['data']['tilawa_id'] as int;
  debugPrint('audioURL: $audioURL');
  return (url: audioURL, recitationID: audioRecitationID);
}

@riverpod
Future<Album> fetchAlbum(
  Ref ref, {
  required int chapterNumber,
  int? recitationID,
  int? reciterID,
}) async {
  final defaultReciterID = ref.watch(defaultReciterProvider).id;
  final playReciterId = reciterID ?? defaultReciterID;
  final url = recitationID == null
      ? '/audio/?reciter_id=$playReciterId&surah_id=$chapterNumber'
      : '/audio/?tilawa_id=$recitationID&surah_id=$chapterNumber';
  final response = await ref.read(dioHelperProvider).getHTTP(url);
  final audioURL = response.data['data']['url'] as String;
  final audioRecitationID = response.data['data']['tilawa_id'] as int;
  final reciter = Reciter.fromJson(
    response.data['data']['tilawa']['reciter'] as Map<String, dynamic>,
  );
  final surah = Surah.fromJson(
    Map<String, dynamic>.from(
      response.data['data']['surah'] as Map<String, dynamic>,
    ),
  );
  return Album(
    surah: surah,
    reciter: reciter,
    url: audioURL,
    recitationID: audioRecitationID,
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
@riverpod
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
  debugPrint('SurahID: $surahID');
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

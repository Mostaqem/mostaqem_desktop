// ignore_for_file: avoid_dynamic_calls, inference_failure_on_untyped_parameter

import 'package:mostaqem/src/core/dio/dio_helper.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/home/home_screen.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/offline/repository/offline_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tuple/tuple.dart';

part 'home_providers.g.dart';

/// Fetches all the chapters
@Riverpod(keepAlive: true)
Future<List<Surah>> fetchAllChapters(FetchAllChaptersRef ref) async {
  final response = await ref.read(dioHelperProvider).getHTTP('/surah');

  return response.data['data']
      .map<Surah>((e) => Surah.fromJson(e as Map<String, Object?>))
      .toList();
}

/// Fetches chapter by [id]
@riverpod
Future<Surah> fetchChapterById(
  FetchChapterByIdRef ref, {
  required int id,
}) async {
  final response = await ref.read(dioHelperProvider).getHTTP('/surah/$id');
  return Surah.fromJson(response.data['data'] as Map<String, dynamic>);
}

/// Fetches audio for chapter by [chapterNumber] and [reciterID]
@riverpod
Future<Tuple2<String, int>> fetchAudioForChapter(
  FetchAudioForChapterRef ref, {
  required int chapterNumber,
  int? recitationID,
  int reciterID = 1,
}) async {
  final url = recitationID == null
      ? '/audio/?reciter_id=$reciterID&surah_id=$chapterNumber'
      : '/audio/?tilawa_id=$recitationID&surah_id=$chapterNumber';

  final response = await ref.read(dioHelperProvider).getHTTP(
        url,
      );

  final audioURL = response.data['data']['url'] as String;
  final audioRecitationID = response.data['data']['tilawa_id'] as int;
  return Tuple2(audioURL, audioRecitationID);
}

/// Filters chapters by search query
@riverpod
Future<List<Surah>> filterSurahByQuery(FilterSurahByQueryRef ref) async {
  final surahs = await ref.watch(fetchAllChaptersProvider.future);
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) {
    return surahs;
  }
  return surahs.where((surah) => surah.arabicName.contains(query)).toList();
}

/// Fetches the next chapter
@riverpod
Future<Surah?> fetchNextSurah(FetchNextSurahRef ref) async {
  final isLocalAudio =
      ref.watch(playerNotifierProvider.notifier).isLocalAudio();
  if (isLocalAudio) {
    final currentPlayer = ref.watch(playerSurahProvider);
    final audios = ref.read(getLocalAudioProvider).value!;
    final currentIndex = audios.indexWhere((e) => e == currentPlayer);
    if (currentIndex == audios.length - 1) {
      return null;
    }
    return audios[currentIndex + 1].surah;
  }
  final currentSurahID = ref.watch(playerSurahProvider)!.surah.id;
  if (currentSurahID < 113) {
    return await ref
        .read(fetchChapterByIdProvider(id: currentSurahID + 1).future);
  }
  return await ref.read(fetchChapterByIdProvider(id: 1).future);
}

/// Fetches random image from Unsplash API
@riverpod
Future<String> fetchRandomImage(FetchRandomImageRef ref) async {
  final request = await ref.watch(dioHelperProvider).getHTTP('/image/random');
  return request.data['data'];
}

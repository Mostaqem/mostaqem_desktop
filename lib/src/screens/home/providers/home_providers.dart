import 'package:mostaqem/src/core/dio/dio_helper.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/surah.dart';
import '../home_screen.dart';

part 'home_providers.g.dart';

@Riverpod(keepAlive: true)
Future<List<Surah>> fetchAllChapters(FetchAllChaptersRef ref) async {
  final response = await ref.read(dioHelperProvider).getHTTP('/surah');

  return response!.data["data"].map<Surah>((e) => Surah.fromJson(e)).toList();
}

@riverpod
Future<Surah> fetchChapterById(FetchChapterByIdRef ref,
    {required int id}) async {
  final response = await ref.read(dioHelperProvider).getHTTP('/surah/$id');

  return Surah.fromJson(response!.data["data"]);
}

@riverpod
Future<String> fetchAudioForChapter(FetchAudioForChapterRef ref,
    {int reciterID = 1, required int chapterNumber}) async {
  final response = await ref
      .read(dioHelperProvider)
      .getHTTP('/audio/?reciter_id=$reciterID/&surah_id=$chapterNumber');

  return response!.data["data"]["url"];
}

@riverpod
Future<List<Surah>> filterSurahByQuery(FilterSurahByQueryRef ref) async {
  final surahs = await ref.watch(fetchAllChaptersProvider.future);
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) {
    return surahs;
  }
  return surahs.where((surah) => surah.arabicName.contains(query)).toList();
}

@riverpod
Future<Surah> fetchNextSurah(FetchNextSurahRef ref) async {
  final currentSurahID = ref.watch(playerSurahProvider).surah.id;
  if (currentSurahID < 113) {
    return await ref
        .read(fetchChapterByIdProvider(id: currentSurahID + 1).future);
  }
  return await ref.read(fetchChapterByIdProvider(id: 1).future);
}

@riverpod
Future<String> fetchRandomImage(FetchRandomImageRef ref) async {
  final request = await ref.watch(dioHelperProvider).getHTTP("/image/random");
  return request!.data["data"];
}

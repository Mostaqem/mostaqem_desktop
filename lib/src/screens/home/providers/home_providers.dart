import 'package:mostaqem/src/core/dio/dio_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../navigation/widgets/player_widget.dart';
import '../data/surah.dart';
import '../home_screen.dart';
import '../widgets/surah_widget.dart';

part 'home_providers.g.dart';

@riverpod
Future<List<Surah>> fetchAllChapters(FetchAllChaptersRef ref) async {
  final response =
      await ref.read(dioHelperProvider).getHTTP('/chapters/?language=ar');

  return response!.data["chapters"]
      .map<Surah>((e) => Surah.fromJson(e))
      .toList();
}

@riverpod
Future<Surah> fetchChapterById(FetchChapterByIdRef ref,
    {required int id}) async {
  final response = await ref.read(dioHelperProvider).getHTTP('/chapters/$id');

  return Surah.fromJson(response!.data["chapter"]);
}

@riverpod
Future<String> fetchAudioForChapter(FetchAudioForChapterRef ref,
    {int reciterID = 1, required int chapterNumber}) async {
  final response = await ref
      .read(dioHelperProvider)
      .getHTTP('/chapter_recitations/$reciterID/$chapterNumber');
  return response!.data["audio_file"]["audio_url"];
}

@riverpod
Future<void> seekID(
  SeekIDRef ref, {
  required int surahID,
  String? surahName,
  String? surahSimpleName,
  required ({int id, String name}) reciter,
}) async {
  if (surahName != null && surahSimpleName != null) {
    final audioURL = await ref.read(fetchAudioForChapterProvider(
            chapterNumber: surahID, reciterID: reciter.id)
        .future);
    ref.read(playerSurahProvider.notifier).state = (
      name: surahName,
      reciter: reciter.name,
      url: audioURL,
      english: surahSimpleName
    );
    ref.read(surahIDProvider.notifier).state = surahID;
    return;
  }
  final surah = await ref.read(fetchChapterByIdProvider(id: surahID).future);
  final audioURL = await ref.read(fetchAudioForChapterProvider(
          chapterNumber: surahID, reciterID: reciter.id)
      .future);
  ref.read(playerSurahProvider.notifier).state = (
    name: surah.arabicName,
    reciter: reciter.name,
    url: audioURL,
    english: surah.simpleName
  );
  ref.read(surahIDProvider.notifier).state = surah.id;
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

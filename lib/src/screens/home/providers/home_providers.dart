import 'package:mostaqem/src/core/dio/dio_helper.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../navigation/widgets/player_widget.dart';
import '../data/surah.dart';
import '../home_screen.dart';
import '../widgets/surah_widget.dart';

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
Future<void> seekID(
  SeekIDRef ref, {
  required int surahID,
  String? surahName,
  String? image,
  String? surahSimpleName,
  required ({int id, String name}) reciter,
}) async {
  if (surahName != null && surahSimpleName != null) {
    final audioURL = await ref.read(fetchAudioForChapterProvider(
            chapterNumber: surahID, reciterID: reciter.id)
        .future);

    final Album currentAlbum = Album(
        name: surahName,
        reciter: reciter.name,
        position: 0,
        image: image ??
            "https://img.freepik.com/premium-photo/illustration-mosque-with-crescent-moon-stars-simple-shapes-minimalist-flat-design_217051-15556.jpg",
        url: audioURL,
        nameEnglish: surahSimpleName);
    ref.read(playerSurahProvider.notifier).state = currentAlbum;
    ref.read(surahIDProvider.notifier).state = surahID;

    return;
  }
  final surah = await ref.read(fetchChapterByIdProvider(id: surahID).future);
  final audioURL = await ref.read(fetchAudioForChapterProvider(
          chapterNumber: surahID, reciterID: reciter.id)
      .future);

  final Album currentAlbum = Album(
      name: surah.arabicName,
      image: surah.image ??
          "https://img.freepik.com/premium-photo/illustration-mosque-with-crescent-moon-stars-simple-shapes-minimalist-flat-design_217051-15556.jpg",
      reciter: reciter.name,
      url: audioURL,
      position: 0,
      nameEnglish: surah.simpleName);
  ref.read(playerSurahProvider.notifier).state = currentAlbum;
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

@Riverpod(keepAlive: true)
Future<Surah> fetchNextSurah(FetchNextSurahRef ref) async {
  final currentSurahID = ref.watch(surahIDProvider);
  if (currentSurahID < 113) {
    return await ref
        .read(fetchChapterByIdProvider(id: currentSurahID + 1).future);
  }
  return await ref.read(fetchChapterByIdProvider(id: 1).future);
}

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/dio/dio_helper.dart';

part 'reading_providers.g.dart';

@riverpod
Future<List<String>> fetchUthmaniScript(FetchUthmaniScriptRef ref,
    {required int surahID}) async {
  final response = await ref
      .read(dioHelperProvider)
      .getHTTP('/quran/verses/uthmani/?chapter_number=$surahID');
  return response!.data["verses"].map<String>((e) => e["text_uthmani"].toString()).toList();
}

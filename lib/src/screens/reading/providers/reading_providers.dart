import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/dio/dio_helper.dart';

part 'reading_providers.g.dart';

@Riverpod(keepAlive: true)
Future<List<String>> fetchUthmaniScript(FetchUthmaniScriptRef ref,
    {required int surahID}) async {
  final response = await ref
      .read(dioHelperProvider)
      .getHTTP('/verse/surah?surah_id=$surahID');
  return response!.data["data"]["verses"].map<String>((e) => e["vers"].toString()).toList();
}

// ignore_for_file: avoid_dynamic_calls, inference_failure_on_untyped_parameter

import 'package:mostaqem/src/core/dio/dio_helper.dart';
import 'package:mostaqem/src/screens/reading/data/script.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reading_providers.g.dart';

@Riverpod(keepAlive: true)
Future<List<Script>> fetchUthmaniScript(
  FetchUthmaniScriptRef ref, {
  required int surahID,
  required int page,
  String? query,
}) async {
  final url = query == null
      ? '/verse/surah?surah_id=$surahID&page=$page&take=13'
      : '/verse/surah?surah_id=$surahID&page=$page&take=13&name=$query';
  final response = await ref.read(dioHelperProvider).getHTTP(url);

  return response.data['data']['verses']
      .map<Script>((e) => Script.fromJson(e as Map<String, Object?>))
      .toList();
}

// ignore_for_file: avoid_dynamic_calls

import 'package:mostaqem/src/core/dio/dio_helper.dart';
import 'package:mostaqem/src/screens/reading/data/script.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reading_providers.g.dart';

@Riverpod(keepAlive: true)
Future<List<Script>> fetchUthmaniScript(
  FetchUthmaniScriptRef ref, {
  required int surahID,
}) async {
  final response = await ref
      .read(dioHelperProvider)
      .getHTTP('/verse/surah?surah_id=$surahID');

  return response.data['data']['verses'].map<Script>(Script.fromJson).toList();
}

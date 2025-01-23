// ignore_for_file: avoid_dynamic_calls, inference_failure_on_untyped_parameter

import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/reading/data/script.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reading_providers.g.dart';

@riverpod
Future<List<Script>> fetchQuran(
  Ref ref, {
  required int surahID,
}) async {
  final quran = await rootBundle.loadString('assets/quran/quran.json');
  final jsonData = jsonDecode(quran) as Map<String, dynamic>;
  final decodedJson = jsonData['$surahID'] as List;
  return decodedJson
      .map<Script>((e) => Script.fromJson(e as Map<String, dynamic>))
      .toList();
}

// ignore_for_file: inference_failure_on_untyped_parameter, avoid_dynamic_calls

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/dio/dio_helper.dart';
import 'package:mostaqem/src/screens/navigation/data/recitation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recitation_repository.g.dart';

@riverpod
Future<List<Recitation>> fetchReciterRecitation(
  Ref ref, {
  required int reciterID,
}) async {
  try {
    final request = await ref
        .watch(dioHelperProvider)
        .getHTTP('/reciter/$reciterID/tilawa');

    return request.data['data']
        .map<Recitation>((e) => Recitation.fromJson(e as Map<String, Object?>))
        .toList();
  } catch (e) {
    if (e is DioException && e.response?.statusCode == 429) {
      final retryAfter = e.response?.headers.value('Retry-After');
      if (retryAfter != null) {
        await Future<dynamic>.delayed(Duration(seconds: int.parse(retryAfter)));
        final request = await ref
            .watch(dioHelperProvider)
            .getHTTP('reciter/$reciterID/tilawa');

        return request.data['data']
            .map<Recitation>(
              (e) => Recitation.fromJson(e as Map<String, Object?>),
            )
            .toList();
      }
    }
  }
  return [];
}

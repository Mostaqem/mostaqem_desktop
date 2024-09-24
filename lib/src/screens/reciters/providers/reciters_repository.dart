// ignore_for_file: avoid_dynamic_calls, inference_failure_on_untyped_parameter

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/dio/dio_helper.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'reciters_repository.g.dart';

abstract class RecitersRepository {
  Future<List<Reciter>> fetchReciters({
    required int page,
    String? query,
  });

  Future<Reciter> fetchReciter({required int id});
}

class RecitersImpl implements RecitersRepository {
  RecitersImpl(this.ref);
  final Ref ref;
  @override
  Future<Reciter> fetchReciter({required int id}) async {
    final request = await ref.watch(dioHelperProvider).getHTTP('/reciter/$id');
    return Reciter.fromJson(request.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<List<Reciter>> fetchReciters({
    required int page,
    String? query,
  }) async {
    final url = query == null
        ? '/reciter?page=$page&take=20'
        : '/reciter?page=$page&take=20&name=$query';
    final request = await ref.watch(dioHelperProvider).getHTTP(url);
    return request.data['data']['reciters']
        .map<Reciter>((e) => Reciter.fromJson(e as Map<String, Object?>))
        .toList();
  }
}

final reciterRepositoryProvider = Provider<RecitersImpl>(RecitersImpl.new);

@riverpod
Future<Reciter> fetchReciter(FetchReciterRef ref, {required int id}) {
  return ref.watch(reciterRepositoryProvider).fetchReciter(id: id);
}

@riverpod
Future<List<Reciter>> fetchReciters(
  FetchRecitersRef ref, {
  required int page,
  String? query,
}) {
  return ref
      .watch(reciterRepositoryProvider)
      .fetchReciters(page: page, query: query);
}

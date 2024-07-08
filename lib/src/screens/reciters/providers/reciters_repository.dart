import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/dio/dio_helper.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'reciters_repository.g.dart';

abstract class RecitersRepository {
  Future<List<Reciter>> fetchReciters();

  Future<Reciter> fetchReciter({required int id});
}

class RecitersImpl implements RecitersRepository {
  final Ref ref;
  RecitersImpl(this.ref);
  @override
  Future<Reciter> fetchReciter({required int id}) async {
    final request = await ref.watch(dioHelperProvider).getHTTP("/reciter/$id");
    return Reciter.fromJson(request!.data["data"]);
  }

  @override
  Future<List<Reciter>> fetchReciters() async {
    final request = await ref.watch(dioHelperProvider).getHTTP("/reciter");
    return request!.data["data"].map<Reciter>((e) => Reciter.fromJson(e)).toList();
  }
}

final reciterRepositoryProvider = Provider<RecitersImpl>(RecitersImpl.new);

@riverpod
Future<Reciter> fetchReciter(FetchReciterRef ref, {required int id}) {
  return ref.watch(reciterRepositoryProvider).fetchReciter(id: id);
}

@riverpod
Future<List<Reciter>> fetchReciters(FetchRecitersRef ref) {
  return ref.watch(reciterRepositoryProvider).fetchReciters();
}

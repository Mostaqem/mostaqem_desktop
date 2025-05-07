import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/dio/apis.dart';
import 'package:mostaqem/src/core/dio/dio_helper.dart';
import 'package:mostaqem/src/screens/broadcast/data/broadcast_data.dart';
import 'package:mostaqem/src/screens/reciters/providers/search_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'broadcast_repository.g.dart';



class BroadcastRepository {
  BroadcastRepository(this.ref);
  final Ref ref;
  final baseAPI = APIs.radioAPIURL;

  @override
  Future<List<Broadcast>> fetchBroadcasts() async {
    final query = ref.watch(searchNotifierProvider('broadcast'));
    final response = await ref
        .watch(dioHelperProvider)
        .getHTTP('/radios', baseAPI: baseAPI);
    final radios = response.data['radios'] as List;
    final broadcasts =
        radios
            .map<Broadcast>(
              (e) => Broadcast.fromJson(e as Map<String, Object?>),
            )
            .toList();

    if (query != null) {
      return broadcasts.where((e) => e.name.contains(query)).toList();
    }

    return broadcasts.where((e)=>e.name.contains("إذاعة")).toList();
  }
}

@riverpod
Future<List<Broadcast>> fetchBroadcasts(Ref ref) =>
    BroadcastRepository(ref).fetchBroadcasts();

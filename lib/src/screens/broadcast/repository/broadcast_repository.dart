// ignore_for_file: avoid_dynamic_calls, public_member_api_docs, prefer_const_constructors

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

  final cairoBroadcast = Broadcast(
    id: 0,
    name: 'إذاعة القران الكريم من القاهرة',
    url:
        'http://n04.radiojar.com/8s5u5tpdtwzuv?rj-ttl=5&rj-tok=AAABlqw9_6IAEMUnhfjSlq3I8A',
  );

  Future<List<Broadcast>> fetchBroadcasts() async {
    final query = ref.watch(searchNotifierProvider('broadcast'));
    final response = await ref
        .watch(dioHelperProvider)
        .getHTTP('/radios', baseAPI: baseAPI);
    final radios = response.data['radios'] as List;
    final broadcasts = radios
            .map<Broadcast>(
              (e) => Broadcast.fromJson(e as Map<String, Object?>),
            )
            .toList()
          ..insert(0,cairoBroadcast);

    if (query != null) {
      return broadcasts.where((e) => e.name.contains(query)).toList();
    }

    return broadcasts.where((e) => e.name.contains('إذاعة')).toList();
  }
}

@riverpod
Future<List<Broadcast>> fetchBroadcasts(Ref ref) =>
    BroadcastRepository(ref).fetchBroadcasts();

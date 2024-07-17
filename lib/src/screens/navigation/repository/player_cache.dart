import 'dart:convert';

import 'package:mostaqem/src/shared/cache/cache_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/album.dart';

part 'player_cache.g.dart';

@riverpod
class PlayerCache extends _$PlayerCache {
  @override
  Album? build() {
    final String? album = CacheHelper.getString("surah");

    if (album != null) {
      return Album.fromJson(jsonDecode(album));
    }
    return null;
  }

  Future<void> setAlbum(Album album) async {
    CacheHelper.setString("surah", jsonEncode(album.toJson()));
    state = album;
  }

  Future<void> removeAlbum() async {
    CacheHelper.remove("surah");
    state = null;
  }
}

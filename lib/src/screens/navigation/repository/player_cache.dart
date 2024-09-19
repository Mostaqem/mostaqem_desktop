import 'dart:convert';

import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/shared/cache/cache_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_cache.g.dart';

@riverpod
class PlayerCache extends _$PlayerCache {
  @override
  Album? build({String key = 'surah'}) {
    try {
      final album = CacheHelper.getString(key);

      if (album != null) {
        return Album.fromJson(jsonDecode(album) as Map<String, dynamic>);
      }
    } catch (e) {
      if (e is TypeError) {
        CacheHelper.clear();
      }
    }

    return null;
  }

  Future<void> setAlbum(Album album, {String key = 'surah'}) async {
    await CacheHelper.setString(key, jsonEncode(album.toJson()));
    state = album;
  }

  Future<void> removeAlbum() async {
    await CacheHelper.remove('surah');
    state = null;
  }
}

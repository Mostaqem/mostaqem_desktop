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
      return Album.fromString(album);
    }
    return null;
  }

  void setAlbum(String album) {
    CacheHelper.setString("surah", album);
    state = Album.fromString(album);
  }

  void removeAlbum() {
    CacheHelper.remove("surah");
    state = null;
  }
}

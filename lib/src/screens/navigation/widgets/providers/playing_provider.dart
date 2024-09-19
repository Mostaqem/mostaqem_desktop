import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_cache.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'playing_provider.g.dart';

@Riverpod(keepAlive: true)
class PlayerSurah extends _$PlayerSurah {
  @override
  Album? build() {
    final cachedSurah = ref.read(playerCacheProvider());
    if (cachedSurah != null) {
      return cachedSurah;
    }

    return null;
  }

  void update(Album? album) {
    state = album;
  }
}

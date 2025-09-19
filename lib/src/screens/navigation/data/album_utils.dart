import 'package:media_kit/media_kit.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';

class AlbumUtils {
  static Album? parseAlbum(int index, Playlist data) {
    if (index < 0 || index >= data.medias.length) return null;
    final extras = data.medias[index].extras;
    if (extras == null) return null;

    return Album.fromExtras(extras);
  }
}

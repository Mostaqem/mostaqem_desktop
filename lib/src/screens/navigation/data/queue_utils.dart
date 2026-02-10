import 'package:media_kit/media_kit.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';

class QueueUtils {
  static bool isAlbumInQueue(List<Media> medias, int surahID) {
    return medias.any((media) {
      final extras = media.extras;
      if (extras == null) return false;
      final surah = extras['surah'] as Map<String, dynamic>?;
      return surah?['id'] == surahID;
    });
  }

  static bool isAlbumInQueueList(List<Album> queue, int surahID) {
    return queue.any((album) => album.surah.id == surahID);
  }
}

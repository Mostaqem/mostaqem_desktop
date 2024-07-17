import '../../home/data/surah.dart';
import '../../reciters/data/reciters_data.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'album.freezed.dart';

part 'album.g.dart';

@Freezed(copyWith: true)
class Album with _$Album {
  const factory Album({
    required Surah surah,
    required Reciter reciter,
    @Default(0) int position,
    required String url,
  }) = _Album;

  factory Album.fromJson(Map<String, Object?> json) => _$AlbumFromJson(json);
}

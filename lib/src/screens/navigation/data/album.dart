import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';

part 'album.freezed.dart';
part 'album.g.dart';

@Freezed(copyWith: true)
class Album with _$Album {
  const factory Album({
    required Surah surah,
    required Reciter reciter,
    required String url,
    required int recitationID,
    @Default(0) int position,
    @Default(false) bool isLocal
  }) = _Album;

  factory Album.fromJson(Map<String, Object?> json) => _$AlbumFromJson(json);
}

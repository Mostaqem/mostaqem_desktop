import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';

final currentSurahProvider = Provider.autoDispose(
  (ref) => ref.watch(playerProvider.select((value) => value.album?.surah)),
);

final currentReciterProvider = Provider.autoDispose((ref) {
  return ref.watch(playerProvider.select((value) => value.album?.reciter));
});

final isAlbumEmptyProvider = Provider.autoDispose((ref) {
  return ref.watch(playerProvider.select((value) => value.album)) == null;
});

final currentAlbumProvider = Provider.autoDispose((ref) {
  return ref.watch(playerProvider.select((value) => value.album));
});

final isLocalProvider = Provider.autoDispose((ref) {
  return ref.watch(
    playerProvider.select((value) => value.album?.isLocal ?? false),
  );
});

final currentRecitationProvider = Provider.autoDispose((ref) {
  return ref.watch(playerProvider.select((value) => value.album?.recitationID));
});

final currentBroadcastProvider = Provider.autoDispose((ref) {
  return ref.watch(playerProvider.select((value) => value.broadcastName));
});

final isBroadcastProvider = Provider.autoDispose((ref) {
  return ref.watch(
    playerProvider.select((value) => value.broadcastName?.isNotEmpty ?? false),
  );
});

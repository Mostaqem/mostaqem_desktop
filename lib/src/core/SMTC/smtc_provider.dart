// import 'dart:io';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:smtc_windows/smtc_windows.dart';

// part 'smtc_provider.g.dart';

// class SMTCRepository {
//   SMTCRepository(this.ref);
//   final Ref ref;
//   SMTCWindows? smtc;
//   static bool get isSupported => Platform.isWindows; 
  

//   void init({
//     required String surah,
//     required String reciter,
//     required String image,
//     required int position,
//     required int duration,
//   }) {
//     smtc = SMTCWindows(
//       metadata: MusicMetadata(
//         title: surah,
//         albumArtist: reciter,
//         artist: reciter,
//         thumbnail: image,
//       ),
//       timeline: PlaybackTimeline(
//         startTimeMs: 0,
//         endTimeMs: duration,
//         positionMs: position,
//         minSeekTimeMs: 0,
//         maxSeekTimeMs: duration,
//       ),
//       config: const SMTCConfig(
//         fastForwardEnabled: false,
//         nextEnabled: true,
//         pauseEnabled: true,
//         playEnabled: true,
//         rewindEnabled: false,
//         prevEnabled: true,
//         stopEnabled: true,
//       ),
//     );
//     smtc!.buttonPressStream.listen((event) {
//       switch (event) {
//         case PressedButton.play:
//           ref.read(playerNotifierProvider.notifier).player.play();
//           smtc!.setPlaybackStatus(PlaybackStatus.playing);
//         case PressedButton.pause:
//           ref.read(playerNotifierProvider.notifier).player.pause();

//           smtc!.setPlaybackStatus(PlaybackStatus.paused);
//         case PressedButton.next:
//           ref.read(playerNotifierProvider.notifier).playNext();
//         case PressedButton.previous:
//           ref.read(playerNotifierProvider.notifier).playPrevious();

//         case PressedButton.stop:
//           smtc!.setPlaybackStatus(PlaybackStatus.stopped);
//         case PressedButton.fastForward:
//           break;
//         case PressedButton.rewind:
//           break;
//         case PressedButton.record:
//           break;
//         case PressedButton.channelUp:
//           break;
//         case PressedButton.channelDown:
//           break;
//       }
//     });
//     smtc?.enableSmtc();
//   }

//   void updateSMTC({
//     required String surah,
//     required String reciter,
//     required String image,
//   }) {
//     smtc!.updateMetadata(
//       MusicMetadata(title: surah, albumArtist: reciter, thumbnail: image),
//     );
//   }
// }

// @riverpod
// SMTCRepository smtcRepo(Ref ref) {
//   return SMTCRepository(ref);
// }

// @riverpod
// void updateSMTC(
//   Ref ref, {
//   required String surah,
//   required String reciter,
//   required String image,
// }) {
//   final repo = ref.watch(smtcRepoProvider);
//   return repo.updateSMTC(surah: surah, reciter: reciter, image: image);
// }

// @riverpod
// void initSMTC(
//   Ref ref, {
//   required String surah,
//   required String reciter,
//   required String image,
//   required int position,
//   required int duration,
// }) {
//   final repo = ref.watch(smtcRepoProvider);
//   return repo.init(
//     surah: surah,
//     reciter: reciter,
//     image: image,
//     position: position,
//     duration: duration,
//   );
// }

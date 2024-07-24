import 'dart:async';
import 'dart:io';

import 'package:media_kit/media_kit.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_cache.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/SMTC/smtc_provider.dart';
import '../../../core/discord/discord_provider.dart';
import '../../../core/mpris/mpris_repository.dart';
import '../../home/providers/home_providers.dart';
import '../../home/widgets/surah_widget.dart';
import '../../reciters/providers/reciters_repository.dart';
import '../data/player.dart';
import '../widgets/player_widget.dart';
import 'package:windows_taskbar/windows_taskbar.dart';

part 'player_repository.g.dart';

@riverpod
class PlayerNotifier extends _$PlayerNotifier {
  final player = Player();

  @override
  AudioState build() {
    init();
    return AudioState();
  }

  void init() {
    final currentPlayer = ref.watch(playerSurahProvider);

    if (currentPlayer == null) return;

    player.open(Media(
      currentPlayer.url,
    ));
    player.stream.position.listen((position) {
      state = state.copyWith(position: position);
    });

    player.stream.duration.listen((duration) {
      state = state.copyWith(duration: duration);

      player.seek(Duration(milliseconds: currentPlayer.position));
    });

    player.stream.buffering.listen((buffering) {
      state = state.copyWith(buffering: buffering);
    });

    player.stream.completed.listen((completed) async {
      if (completed) {
        if (currentPlayer.surah.id < 114) {
          await playNext();
        } else {
          await play(surahID: 1);
        }
      }
    });
    player.stream.playing.listen((playing) async {
      state = state.copyWith(isPlaying: playing);

      if (Platform.isWindows) {
        windowThumbnailBar();
        ref.read(initSMTCProvider(
            duration: state.duration.inMilliseconds,
            position: state.position.inMilliseconds,
            image: currentPlayer.surah.image ??
                "https://img.freepik.com/premium-photo/illustration-mosque-with-crescent-moon-stars-simple-shapes-minimalist-flat-design_217051-15556.jpg",
            surah: currentPlayer.surah.arabicName,
            reciter: currentPlayer.reciter.arabicName));
      }

      if (Platform.isLinux) {
        ref.read(createMetadataProvider(
            reciterName: currentPlayer.reciter.arabicName,
            url: currentPlayer.url,
            surah: currentPlayer.surah.arabicName,
            image: currentPlayer.surah.image!,
            position: state.position));
      }
    });

    ref.listen(playerSurahProvider, (_, n) async {
      ref.watch(playerCacheProvider.notifier).removeAlbum();
      player.playOrPause();

      if (Platform.isWindows) {
        ref.read(updateSMTCProvider(
            image: n!.surah.image ??
                "https://img.freepik.com/premium-photo/illustration-mosque-with-crescent-moon-stars-simple-shapes-minimalist-flat-design_217051-15556.jpg",
            surah: n.surah.arabicName,
            reciter: n.reciter.arabicName));
      }

      ref.read(updateRPCDiscordProvider(
          surahName: n!.surah.simpleName,
          reciter: n.reciter.englishName,
          position: state.position.inMilliseconds,
          duration: state.duration.inMilliseconds));

      player.open(Media(n.url));
    });
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    String hoursStr = hours > 0 ? '$hours:' : '';
    String minutesStr = twoDigits(minutes);
    String secondsStr = twoDigits(seconds);

    return '$hoursStr$minutesStr:$secondsStr';
  }

  bool isFirstChapter() {
    final currentPlayer = ref.read(playerSurahProvider);
    if (currentPlayer == null) {
      return false;
    }
    return currentPlayer.surah.id > 1;
  }

  bool isLastchapter() {
    final currentPlayer = ref.read(playerSurahProvider);
    if (currentPlayer == null) {
      return false;
    }
    return currentPlayer.surah.id < 114;
  }

  void handlePlayPause() {
    if (state.isPlaying) {
      player.pause();

      state = state.copyWith(isPlaying: false);
    } else {
      player.play();

      state = state.copyWith(isPlaying: true);
    }
  }

  Future<void> playNext() async {
    final currentPlayer = ref.read(playerSurahProvider);

    final chosenReciter =
        ref.read(reciterProvider) ?? ref.read(playerSurahProvider)!.reciter;

    int nextID = currentPlayer!.surah.id + 1;
    final nextSurah =
        await ref.read(fetchChapterByIdProvider(id: nextID).future);
    final audioURL = await ref.read(fetchAudioForChapterProvider(
            chapterNumber: nextID, reciterID: chosenReciter.id)
        .future);

    final nextAlbum = Album(
        surah: nextSurah, reciter: chosenReciter, url: audioURL, position: 0);

    ref.read(playerSurahProvider.notifier).state = nextAlbum;
  }

  bool isLocalAudio() {
    final currentPlayer = ref.read(playerSurahProvider);
    if (currentPlayer != null) {
      return currentPlayer.url.contains("http") ? false : true;
    }
    return false;
  }

  Future<void> playPrevious() async {
    final currentPlayer = ref.read(playerSurahProvider);
    int nextID = currentPlayer!.surah.id - 1;
    final chosenReciter =
        ref.read(reciterProvider) ?? ref.read(playerSurahProvider)!.reciter;

    final nextSurah =
        await ref.read(fetchChapterByIdProvider(id: nextID).future);
    final audioURL = await ref.read(fetchAudioForChapterProvider(
            chapterNumber: nextID, reciterID: chosenReciter.id)
        .future);

    final nextAlbum = Album(
        surah: nextSurah, reciter: chosenReciter, url: audioURL, position: 0);

    ref.read(playerSurahProvider.notifier).state = nextAlbum;
  }

  Future<void> play({
    required int surahID,
  }) async {
    final chosenReciterID = ref.read(reciterProvider)?.id ?? 1;
    final surah = await ref.read(fetchChapterByIdProvider(id: surahID).future);
    final reciter =
        await ref.read(fetchReciterProvider(id: chosenReciterID).future);

    final audioURL = await ref.read(fetchAudioForChapterProvider(
            chapterNumber: surahID, reciterID: chosenReciterID)
        .future);

    final album =
        Album(surah: surah, reciter: reciter, url: audioURL, position: 0);

    ref.read(playerSurahProvider.notifier).state = album;
  }

  void loop() {
    PlaylistMode mode = player.state.playlistMode;

    if (mode == PlaylistMode.none) {
      player.setPlaylistMode(PlaylistMode.single);
      state = state.copyWith(loop: PlaylistMode.single);

      return;
    }
    if (mode == PlaylistMode.single) {
      player.setPlaylistMode(PlaylistMode.loop);
      state = state.copyWith(loop: PlaylistMode.loop);

      return;
    }
    if (mode == PlaylistMode.loop) {
      player.setPlaylistMode(PlaylistMode.none);
      state = state.copyWith(loop: PlaylistMode.none);

      return;
    }
  }

  Future<void> handleSeek(double value) async {
    await player.seek(
      Duration(seconds: value.toInt()),
    );
  }

  Future<void> handleVolume(double value) async {
    await player.setVolume(value * 100);

    state = state.copyWith(volume: value);
  }

  windowThumbnailBar() {
    WindowsTaskbar.setFlashTaskbarAppIcon();

    WindowsTaskbar.setThumbnailToolbar([
      ThumbnailToolbarButton(
        ThumbnailToolbarAssetIcon('assets/img/skip_previous.ico'),
        "بعد",
        () async {
          await playNext();
        },
      ),
      state.isPlaying
          ? ThumbnailToolbarButton(
              ThumbnailToolbarAssetIcon('assets/img/pause.ico'),
              "ايقاف ",
              () {
                player.pause();
                state = state.copyWith(isPlaying: false);
              },
            )
          : ThumbnailToolbarButton(
              ThumbnailToolbarAssetIcon('assets/img/play.ico'),
              "تشغيل",
              () {
                player.play();
                state = state.copyWith(isPlaying: true);
              },
            ),
      ThumbnailToolbarButton(
        ThumbnailToolbarAssetIcon('assets/img/skip_next.ico'),
        "قبل",
        () async {
          await playPrevious();
        },
      ),
    ]);
  }

  (String currentTime, String durationTime) playerTime() {
    String currentTime = formatDuration(state.position);
    String durationTime = formatDuration(state.duration);
    return (currentTime, durationTime);
  }
}

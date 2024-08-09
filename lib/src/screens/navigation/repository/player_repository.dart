import 'dart:async';
import 'dart:io';

import 'package:media_kit/media_kit.dart';
import 'package:mostaqem/src/core/SMTC/smtc_provider.dart';
import 'package:mostaqem/src/core/discord/discord_provider.dart';
import 'package:mostaqem/src/core/mpris/mpris_repository.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/home/widgets/surah_widget.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/data/player.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_cache.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player_widget.dart';
import 'package:mostaqem/src/screens/offline/repository/offline_repository.dart';
import 'package:mostaqem/src/screens/reciters/providers/reciters_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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

    if (isLocalAudio()) {
      final audios = ref.watch(getLocalAudioProvider).value;
      final firstAudio = audios!.first;

      final nextAudios = audios.where((e) => e != firstAudio);
      for (final e in nextAudios) {
        player.add(Media(e.url));
      }
    }

    player.open(
      Media(
        currentPlayer.url,
      ),
    );
    player.stream.position.listen((position) {
      state = state.copyWith(position: position);
    });

    player.stream.duration.listen((duration) {
      state = state.copyWith(duration: duration);

      // player.seek(Duration(milliseconds: currentPlayer.position)); // TODO: FIX THIS
    });

    player.stream.buffer.listen((buffering) {
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
        ref.read(
          initSMTCProvider(
            duration: state.duration.inMilliseconds,
            position: state.position.inMilliseconds,
            image: currentPlayer.surah.image ??
                'https://img.freepik.com/premium-photo/illustration-mosque-with-crescent-moon-stars-simple-shapes-minimalist-flat-design_217051-15556.jpg',
            surah: currentPlayer.surah.arabicName,
            reciter: currentPlayer.reciter.arabicName,
          ),
        );
      }

      if (Platform.isLinux) {
        ref.read(
          createMetadataProvider(
            reciterName: currentPlayer.reciter.arabicName,
            url: currentPlayer.url,
            surah: currentPlayer.surah.arabicName,
            image: currentPlayer.surah.image!,
            position: state.position,
          ),
        );
      }
    });

    ref.listen(playerSurahProvider, (_, n) async {
      await ref.watch(playerCacheProvider.notifier).removeAlbum();
      await player.playOrPause();

      if (Platform.isWindows) {
        ref.read(
          updateSMTCProvider(
            image: n!.surah.image ??
                'https://img.freepik.com/premium-photo/illustration-mosque-with-crescent-moon-stars-simple-shapes-minimalist-flat-design_217051-15556.jpg',
            surah: n.surah.arabicName,
            reciter: n.reciter.arabicName,
          ),
        );
      }

      ref.read(
        updateRPCDiscordProvider(
          surahName: n!.surah.simpleName,
          reciter: n.reciter.englishName,
          position: state.position.inMilliseconds,
          duration: state.duration.inMilliseconds,
        ),
      );
    });
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hoursStr = hours > 0 ? '$hours:' : '';
    final minutesStr = twoDigits(minutes);
    final secondsStr = twoDigits(seconds);

    return '$hoursStr$minutesStr:$secondsStr';
  }

  bool isFirstChapter() {
    final currentPlayer = ref.watch(playerSurahProvider);
    if (isLocalAudio()) {
      final audios = ref.watch(getLocalAudioProvider).value!;
      final currentIndex = audios.indexWhere((e) => e == currentPlayer);

      return currentIndex > 0;
    }
    if (currentPlayer == null) {
      return false;
    }
    return currentPlayer.surah.id > 1;
  }

  bool isLastchapter() {
    final currentPlayer = ref.watch(playerSurahProvider);
    if (isLocalAudio()) {
      final audios = ref.watch(getLocalAudioProvider).value!;
      final currentIndex = audios.indexWhere((e) => e == currentPlayer);
      final lastIndex = audios.length - 1;
      return currentIndex < lastIndex;
    }
    if (currentPlayer == null) {
      return false;
    }
    return currentPlayer.surah.id < 114;
  }

  Future<void> handlePlayPause() async {
    if (state.isPlaying) {
      await player.pause();

      state = state.copyWith(isPlaying: false);
    } else {
      await player.play();

      state = state.copyWith(isPlaying: true);
    }
  }

  Future<void> playNext() async {
    final currentPlayer = ref.watch(playerSurahProvider);
    if (isLocalAudio()) {
      await player.next();
      final audios = ref.watch(getLocalAudioProvider).value!;
      final currentIndex = audios.indexWhere((e) => e == currentPlayer);
      ref.watch(playerSurahProvider.notifier).state = audios[currentIndex + 1];
      return;
    }

    final chosenReciter =
        ref.read(reciterProvider) ?? ref.read(playerSurahProvider)!.reciter;

    final nextID = currentPlayer!.surah.id + 1;
    final nextSurah =
        await ref.read(fetchChapterByIdProvider(id: nextID).future);
    final audioURL = await ref.read(
      fetchAudioForChapterProvider(
        chapterNumber: nextID,
        reciterID: chosenReciter.id,
      ).future,
    );

    final nextAlbum = Album(
      surah: nextSurah,
      reciter: chosenReciter,
      url: audioURL,
    );

    ref.read(playerSurahProvider.notifier).state = nextAlbum;
  }

  bool isLocalAudio() {
    final currentPlayer = ref.read(playerSurahProvider);
    if (currentPlayer != null) {
      return !currentPlayer.url.contains('http');
    }
    return false;
  }

  Future<void> playPrevious() async {
    final currentPlayer = ref.read(playerSurahProvider);
    if (isLocalAudio()) {
      await player.previous();
      final audios = ref.watch(getLocalAudioProvider).value!;
      final currentIndex = audios.indexWhere((e) => e == currentPlayer);
      ref.watch(playerSurahProvider.notifier).state = audios[currentIndex - 1];
      return;
    }
    final nextID = currentPlayer!.surah.id - 1;
    final chosenReciter =
        ref.read(reciterProvider) ?? ref.read(playerSurahProvider)!.reciter;

    final nextSurah =
        await ref.read(fetchChapterByIdProvider(id: nextID).future);
    final audioURL = await ref.read(
      fetchAudioForChapterProvider(
        chapterNumber: nextID,
        reciterID: chosenReciter.id,
      ).future,
    );

    final nextAlbum = Album(
      surah: nextSurah,
      reciter: chosenReciter,
      url: audioURL,
    );

    ref.read(playerSurahProvider.notifier).state = nextAlbum;
  }

  Future<void> play({
    required int surahID,
  }) async {
    final chosenReciterID = ref.read(reciterProvider)?.id ?? 1;
    final surah = await ref.read(fetchChapterByIdProvider(id: surahID).future);
    final reciter =
        await ref.read(fetchReciterProvider(id: chosenReciterID).future);

    final audioURL = await ref.read(
      fetchAudioForChapterProvider(
        chapterNumber: surahID,
        reciterID: chosenReciterID,
      ).future,
    );

    final album = Album(surah: surah, reciter: reciter, url: audioURL);

    ref.read(playerSurahProvider.notifier).state = album;
  }

  void loop() {
    final mode = player.state.playlistMode;

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

  Future<void> handleSeek(Duration value) async {
    await player.seek(value);
  }

  Future<void> handleVolume(double value) async {
    await player.setVolume(value * 100);

    state = state.copyWith(volume: value);
  }

  void windowThumbnailBar() {
    WindowsTaskbar.setFlashTaskbarAppIcon();

    WindowsTaskbar.setThumbnailToolbar([
      ThumbnailToolbarButton(
        ThumbnailToolbarAssetIcon('assets/img/skip_previous.ico'),
        'بعد',
        () async {
          await playNext();
        },
      ),
      if (state.isPlaying)
        ThumbnailToolbarButton(
          ThumbnailToolbarAssetIcon('assets/img/pause.ico'),
          'ايقاف ',
          () {
            player.pause();
            state = state.copyWith(isPlaying: false);
          },
        )
      else
        ThumbnailToolbarButton(
          ThumbnailToolbarAssetIcon('assets/img/play.ico'),
          'تشغيل',
          () {
            player.play();
            state = state.copyWith(isPlaying: true);
          },
        ),
      ThumbnailToolbarButton(
        ThumbnailToolbarAssetIcon('assets/img/skip_next.ico'),
        'قبل',
        () async {
          await playPrevious();
        },
      ),
    ]);
  }

  (String currentTime, String durationTime) playerTime() {
    final currentTime = formatDuration(state.position);
    final durationTime = formatDuration(state.duration);
    return (currentTime, durationTime);
  }
}

class PlayerNotifierMock extends _$PlayerNotifier implements PlayerNotifier {
  @override
  AudioState build() {
    return AudioState();
  }

  @override
  Future<void> handlePlayPause() async {
    state = state.copyWith(isPlaying: true);
  }

  @override
  bool isLocalAudio() {
    return false;
  }

  @override
  bool isLastchapter() {
    return true;
  }

  @override
  bool isFirstChapter() {
    return true;
  }

  @override
  (String, String) playerTime() {
    return ('', '');
  }

  @override
  Future<void> handleVolume(double value) async {
    state = state.copyWith(volume: value);
  }

  @override
  String formatDuration(Duration duration) {
    throw UnimplementedError();
  }

  @override
  Future<void> handleSeek(Duration value) {
    throw UnimplementedError();
  }

  @override
  void init() {}

  @override
  void loop() {}

  @override
  Future<void> play({required int surahID}) {
    throw UnimplementedError();
  }

  @override
  Future<void> playNext() {
    throw UnimplementedError();
  }

  @override
  Future<void> playPrevious() {
    throw UnimplementedError();
  }

  @override
  Player get player => throw UnimplementedError();

  @override
  void windowThumbnailBar() {
    throw UnimplementedError();
  }
}

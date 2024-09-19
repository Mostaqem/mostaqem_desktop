import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lrc/lrc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:mostaqem/src/core/SMTC/smtc_provider.dart';
import 'package:mostaqem/src/core/discord/discord_provider.dart';
import 'package:mostaqem/src/core/env/env.dart';
import 'package:mostaqem/src/core/mpris/mpris_repository.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/home/widgets/surah_widget.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/data/player.dart';
import 'package:mostaqem/src/screens/navigation/repository/lyrics.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_cache.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/recitation_widget.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/offline/repository/offline_repository.dart';
import 'package:mostaqem/src/screens/reciters/providers/default_reciter.dart';
import 'package:mostaqem/src/screens/reciters/providers/reciters_repository.dart';
import 'package:mostaqem/src/shared/internet_checker/network_checker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tuple/tuple.dart';
import 'package:windows_taskbar/windows_taskbar.dart';

import 'package:mostaqem/src/shared/cache/cache_helper.dart';

import 'package:mostaqem/src/screens/navigation/data/cached_metadata.dart';

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
    final networkState = ref.watch(getConnectionProvider).value;

    if (networkState == InternetConnectionStatus.disconnected) {
      player.pause();
    }

    final currentPlayer = ref.watch(playerSurahProvider);
    if (currentPlayer == null) return;

    if (isLocalAudio()) {
      final audios = ref.watch(getLocalAudioProvider).value;
      final firstAudio = audios?.first;

      final nextAudios = audios?.where((e) => e != firstAudio);
      if (nextAudios == null) return;

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
            image: currentPlayer.surah.image ?? '',
            position: state.position,
          ),
        );
      }
    });

    ref.listen(playerSurahProvider, (_, n) async {
      await ref.watch(playerCacheProvider().notifier).removeAlbum();
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
      final audios = ref.watch(getLocalAudioProvider).value;
      if (audios == null) return false;
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
      final audios = ref.watch(getLocalAudioProvider).value;
      if (audios == null) return false;
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
      final audios = ref.watch(getLocalAudioProvider).value;
      final currentIndex = audios!.indexWhere((e) => e == currentPlayer);
      ref.watch(playerSurahProvider.notifier).update(audios[currentIndex + 1]);
      return;
    }
    final surahID = currentPlayer!.surah.id;
    final recID = ref.watch(recitationProvider);

    final nextID = surahID + 1;
    final chosenReciter =
        ref.read(reciterProvider) ?? ref.read(playerSurahProvider)!.reciter;
    final defaultReciter = ref.watch(defaultReciterProvider);
    final playingReciter =
        defaultReciter == chosenReciter ? defaultReciter : chosenReciter;

    final mixID = 'audio_${recID ?? playingReciter.id + surahID}';

    final cachedAlbum = ref.read(playerCacheProvider(key: mixID));
    Album nextAlbum;
    if (cachedAlbum == null) {
      // If Album is not cached
      final nextSurah =
          await ref.read(fetchChapterByIdProvider(id: nextID).future);
      final surahAudio = await ref.read(
        fetchAudioForChapterProvider(
          chapterNumber: nextID,
          reciterID: playingReciter.id,
          recitationID: recID,
        ).future,
      );

      nextAlbum = Album(
        surah: nextSurah,
        reciter: playingReciter,
        recitationID: surahAudio.item2,
        url: surahAudio.item1,
      );
      await ref
          .read(playerCacheProvider(key: mixID).notifier)
          .setAlbum(nextAlbum, key: mixID);
      await DefaultCacheManager().downloadFile(surahAudio.item1);

      ref.read(playerSurahProvider.notifier).update(nextAlbum);
      ref.read(recitationProvider.notifier).state = surahAudio.item2;
      return;
    }
    final cachedFile =
        await DefaultCacheManager().getFileFromCache(cachedAlbum.url);
    debugPrint('Cached File: $cachedFile');
    // If Album is not cached
    final nextSurah =
        await ref.read(fetchChapterByIdProvider(id: nextID).future);
    final surahAudio = await ref.read(
      fetchAudioForChapterProvider(
        chapterNumber: nextID,
        reciterID: playingReciter.id,
        recitationID: recID,
      ).future,
    );

    nextAlbum = Album(
      surah: nextSurah,
      reciter: playingReciter,
      recitationID: 180,
      url: surahAudio.item1,
    );
    await ref
        .read(playerCacheProvider(key: mixID).notifier)
        .setAlbum(nextAlbum, key: mixID);

    ref.read(playerSurahProvider.notifier).update(nextAlbum);

    // log('Cached File $cachedFile');
    // if (cachedFile != null) {
    //   log('Load from cached');

    //   nextAlbum = Album(
    //     surah: cachedAlbum.surah,
    //     reciter: cachedAlbum.reciter,
    //     url: cachedFile.file.path,
    //     recitationID: cachedAlbum.recitationID,
    //   );
    //   ref.read(playerSurahProvider.notifier).update(nextAlbum);
    //   return;
    // }
    // log('Not same Reciter');
    // // checks if the choosen reciter from the list is same as the cached reciter
    // final nextSurah =
    //     await ref.read(fetchChapterByIdProvider(id: nextID).future);

    // final surahAudio = await ref.read(
    //   fetchAudioForChapterProvider(
    //     chapterNumber: nextID,
    //     reciterID: chosenReciter.id,
    //     recitationID: recID,
    //   ).future,
    // );
    // nextAlbum = Album(
    //   surah: nextSurah,
    //   reciter: chosenReciter,
    //   url: surahAudio.item1,
    //   recitationID: recID ?? 0,
    // );
    // log('NextAlbum $nextAlbum');
    // ref.read(playerSurahProvider.notifier).update(nextAlbum);
    // await DefaultCacheManager().downloadFile(surahAudio.item1);
  }

  bool isLocalAudio() {
    final currentPlayer = ref.read(playerSurahProvider);
    if (currentPlayer != null) {
      return currentPlayer.isLocal;
    }
    return false;
  }

  Future<void> playPrevious() async {
    final currentPlayer = ref.read(playerSurahProvider);
    if (isLocalAudio()) {
      await player.previous();
      final audios = ref.watch(getLocalAudioProvider).value;
      final currentIndex = audios!.indexWhere((e) => e == currentPlayer);
      ref.watch(playerSurahProvider.notifier).state = audios[currentIndex - 1];
      return;
    }
    final surahID = currentPlayer!.surah.id ?? 0;
    final recitationID = currentPlayer.recitationID;
    final previousID = surahID - 1;

    final mixID = 'audio_${recitationID + surahID}';
    log('MixID $mixID');
    final cachedAlbum = ref.read(playerCacheProvider(key: mixID));

    final chosenReciter =
        ref.read(reciterProvider) ?? ref.read(playerSurahProvider)!.reciter;
    Album previousAlbum;

    if (cachedAlbum == null) {
      final previousSurah =
          await ref.read(fetchChapterByIdProvider(id: previousID).future);
      final audioURL = await ref.read(
        fetchAudioForChapterProvider(
          chapterNumber: previousID,
          reciterID: chosenReciter.id,
          recitationID: ref.watch(recitationProvider),
        ).future,
      );

      previousAlbum = Album(
        surah: previousSurah,
        reciter: chosenReciter,
        recitationID: audioURL.item2,
        url: audioURL.item1,
      );

      ref.read(playerSurahProvider.notifier).update(previousAlbum);
      await DefaultCacheManager().downloadFile(audioURL.item1);
      await ref
          .read(playerCacheProvider(key: mixID).notifier)
          .setAlbum(previousAlbum, key: mixID);
      return;
    }
    final cachedFile =
        await DefaultCacheManager().getFileFromCache(cachedAlbum.url);
    if (cachedFile != null) {
      print('Loaded from cache');
      previousAlbum = Album(
        surah: cachedAlbum.surah,
        reciter: cachedAlbum.reciter,
        url: cachedFile.file.path,
        recitationID: cachedAlbum.recitationID,
      );
      ref.read(playerSurahProvider.notifier).update(previousAlbum);
    }
    final previousSurah =
        await ref.read(fetchChapterByIdProvider(id: previousID).future);
    final audioURL = await ref.read(
      fetchAudioForChapterProvider(
        chapterNumber: previousID,
        reciterID: chosenReciter.id,
        recitationID: ref.watch(recitationProvider),
      ).future,
    );

    previousAlbum = Album(
      surah: previousSurah,
      reciter: chosenReciter,
      recitationID: audioURL.item2,
      url: audioURL.item1,
    );

    ref.read(playerSurahProvider.notifier).update(previousAlbum);
    await DefaultCacheManager().downloadFile(audioURL.item1);
  }

  Future<void> play({
    required int surahID,
    int? recitationID,
  }) async {
    final mixID = 'audio_${recitationID ?? 0 + surahID}';
    final defaultReciterId = ref.read(defaultReciterProvider).id;
    final chosenReciterID = ref.read(reciterProvider)?.id ?? defaultReciterId;
    final cachedAlbum = ref.read(playerCacheProvider(key: mixID));
    debugPrint('Cached Album: $cachedAlbum');
    final reciter =
        await ref.read(fetchReciterProvider(id: chosenReciterID).future);
    debugPrint(reciter.toString());
    Album album;
    if (cachedAlbum == null) {
      final surah =
          await ref.read(fetchChapterByIdProvider(id: surahID).future);

      final audio = await ref.read(
        fetchAudioForChapterProvider(
          chapterNumber: surahID,
          reciterID: chosenReciterID,
          recitationID: recitationID,
        ).future,
      );

      album = Album(
        surah: surah,
        reciter: reciter,
        url: audio.item1,
        recitationID: recitationID ?? audio.item2,
      );
      await ref
          .read(playerCacheProvider(key: mixID).notifier)
          .setAlbum(album, key: mixID);

      ref.read(playerSurahProvider.notifier).state = album;

      await DefaultCacheManager().downloadFile(audio.item1);
      return;
    }

    final cachedFile =
        await DefaultCacheManager().getFileFromCache(cachedAlbum.url);

    final userRecitationID = recitationID ?? cachedAlbum.recitationID;
    if (cachedFile != null) {
      debugPrint('Playing from cache');
      album = Album(
        surah: cachedAlbum.surah,
        reciter: reciter,
        url: cachedFile.file.path,
        recitationID: userRecitationID,
      );
      ref.read(playerSurahProvider.notifier).state = album;
    }
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
    state = state.copyWith(position: value);
  }

  Future<void> handleVolume(double value) async {
    await player.setVolume(value * 100);

    state = state.copyWith(volume: value);
  }

  final String lyrics = '''
[00:00.00] بِسۡمِ
[00:01.04] ٱللَّهِ
[00:01.66] ٱلرَّحۡمَٰنِ
[00:02.61] ٱلرَّحِيمِ
[00:04.37] ٱلۡحَمۡدُ
[00:06.09] لِلَّهِ
[00:06.94] رَبِّ
[00:07.40] ٱلۡعَٰلَمِينَ
[00:09.68] ٱلرَّحۡمَٰنِ
[00:11.65] ٱلرَّحِيمِ
[00:13.71] مَٰلِكِ
[00:15.77] يَوۡمِ
[00:16.27] ٱلدِّينِ
[00:18.26] إِيَّاكَ
[00:19.96] نَعۡبُدُ
[00:20.73] وَإِيَّاكَ
[00:21.76] نَسۡتَعِينُ
[00:23.88] ٱهۡدِنَا
[00:25.49] ٱلصِّرَٰطَ
[00:26.30] ٱلۡمُسۡتَقِيمَ
[00:28.69] صِرَٰطَ
[00:31.05] ٱلَّذِينَ
[00:31.91] أَنۡعَمۡتَ
[00:32.79] عَلَيۡهِمۡ
[00:33.61] غَيۡرِ
[00:34.21] ٱلۡمَغۡضُوبِ
[00:35.23] عَلَيۡهِمۡ
[00:36.27] وَلَا
[00:36.49] ٱلضَّآلِّينَ
''';

  Stream<Tuple2<int, List<Lyrics>>> syncLyrics() async* {
    final current = <Lyrics>[];
    final currentLyricsAveragedMap = <int, String>{};
    if (Lrc.isValid(lyrics)) {
      current.addAll(
        Lrc.parse(lyrics).lyrics.map(
              (e) => Lyrics(time: e.timestamp.inMilliseconds, words: e.lyrics),
            ),
      );
      for (final lyric in current) {
        currentLyricsAveragedMap[lyric.time ~/ 1000] = lyric.words;
      }

      while (true) {
        var currentIndex = -1;
        var currentLyric = '';
        for (var i = 0; i < currentLyricsAveragedMap.entries.length; i++) {
          final lyric = currentLyricsAveragedMap.entries.elementAt(i);
          if (lyric.key == state.position.inMilliseconds ~/ 1000) {
            currentIndex = i;
            currentLyric = lyric.value;
          }
        }
        if (currentIndex != -1) {
          print('Current Lyric: $currentLyric, Index: $currentIndex');
          yield Tuple2(currentIndex, current);
        }
        await Future.delayed(
          const Duration(milliseconds: 500),
        ); // Adjust delay as needed
      }
    }
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
  Future<void> play({required int surahID, int? recitationID}) {
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

  @override
  String get lyrics => throw UnimplementedError();

  @override
  Stream<Tuple2<int, List<Lyrics>>> syncLyrics() {
    // TODO: implement syncLyrics
    throw UnimplementedError();
  }

  @override
  Future<CachedAudioMetadata?> getCachedAudioMetadata(
    int recitationID,
    int surahID,
  ) {
    // TODO: implement getCachedAudioMetadata
    throw UnimplementedError();
  }

  @override
  Future<void> cacheAudioMetadata({
    required int recitationID,
    required int surahID,
    required CachedAudioMetadata metadata,
  }) {
    // TODO: implement cacheAudioMetadata
    throw UnimplementedError();
  }
}

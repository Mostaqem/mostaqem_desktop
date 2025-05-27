// ignore_for_file: inference_failure_on_instance_creation

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:media_kit/media_kit.dart';
import 'package:mostaqem/src/core/discord/discord_provider.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/data/player.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_cache.dart';
import 'package:mostaqem/src/screens/offline/repository/offline_repository.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';
import 'package:mostaqem/src/screens/reciters/providers/reciters_repository.dart';
import 'package:mostaqem/src/shared/internet_checker/network_checker.dart';
import 'package:mostaqem/src/shared/widgets/shortcuts/shortcuts_focus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:windows_taskbar/windows_taskbar.dart';

part 'player_repository.g.dart';

@riverpod
class PlayerNotifier extends _$PlayerNotifier {
  final player = Player();

  @override
  AudioState build() {
    final audioState = AudioState();
    final networkState = ref.watch(getConnectionProvider).value;
    if (networkState == InternetConnectionStatus.disconnected ||
        networkState == null) {
      player.pause();
    } else {
      init();

      final cachedSurah = ref.read(playerCacheProvider());
      if (cachedSurah != null) {
        player.open(
          Media(
            cachedSurah.url,
            extras: {
              'surah': cachedSurah.surah.toJson(),
              'reciter': cachedSurah.reciter.toJson(),
              'recitationID': cachedSurah.recitationID,
              'url': cachedSurah.url,
            },
          ),
          play: false,
        );

        return audioState.copyWith(
          album: cachedSurah,
          duration: Duration(seconds: cachedSurah.duration),
        );
      }
    }
    return audioState;
  }

  void init() {
    player.stream.playlist.listen((data) async {
      if (player.state.playlist.medias.length == 1) {
        if (isLocalAudio()) {
          await addLocalQueue();
        } else {
          await addToQueue();
        }
      }
      Album? parseAlbum(int index) {
        if (index < 0 || index >= data.medias.length) return null;
        final extras = data.medias[index].extras;
        if (extras == null) return null;

        return Album(
          surah: Surah.fromJson(extras['surah'] as Map<String, dynamic>),
          reciter: Reciter.fromJson(extras['reciter'] as Map<String, dynamic>),
          url: extras['url'] as String,
          recitationID: extras['recitationID'] as int,
        );
      }

      state = state.copyWith(
        album: parseAlbum(data.index),
        nextAlbum: parseAlbum(data.index + 1),
        queueIndex: data.index,
        queue: data.medias
            .map((media) {
              final extras = media.extras;
              return extras == null
                  ? null
                  : Album(
                      surah: Surah.fromJson(
                        extras['surah'] as Map<String, dynamic>,
                      ),
                      reciter: Reciter.fromJson(
                        extras['reciter'] as Map<String, dynamic>,
                      ),
                      url: extras['url'] as String,
                      recitationID: extras['recitationID'] as int,
                    );
            })
            .whereType<Album>()
            .toList(),
      );
    });

    player.stream.position.listen((position) {
      state = state.copyWith(position: position);
    });

    player.stream.duration.listen((duration) async {
      state = state.copyWith(duration: duration);

      if (state.album?.position != 0) {
        final positionAlbum = Duration(
          milliseconds: state.album?.position ?? 0,
        );
        await player.seek(positionAlbum);
      }

      await ref.read(
        updateRPCDiscordProvider(
          surahName: state.album?.surah.simpleName ?? '',
          reciter: state.album?.reciter.englishName ?? '',
          url: state.album?.url ?? '',
        ).future,
      );
    });

    player.stream.buffer.listen((buffering) {
      state = state.copyWith(buffering: buffering);
    });

    player.stream.playing.listen((playing) async {
      state = state.copyWith(isPlaying: playing);
      if (Platform.isWindows) {
        windowThumbnailBar();
      }
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
    if (isLocalAudio()) {
      final audios = ref.read(getLocalAudioProvider).value;
      if (audios == null) return false;

      return player.state.playlist.index == 0;
    }

    final currentSurah = state.album?.surah;
    if (currentSurah == null) {
      return false;
    }
    return player.state.playlist.index == 0;
  }

  bool isLastchapter() {
    if (isLocalAudio()) {
      final audios = ref.read(getLocalAudioProvider).value;
      if (audios == null) return false;

      final currentIndex = player.state.playlist.index;
      final lastIndex = audios.length - 1;
      debugPrint(
        'CurrentIndex: ${player.state.playlist.index}, Lastindex:$lastIndex',
      );
      return currentIndex <= lastIndex;
    }
    final currentSurah = state.album?.surah;

    if (currentSurah == null) {
      return false;
    }
    return player.state.playlist.index == 19;
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

  Future<void> localPlay({required Album album}) async {
    state = state.copyWith(album: album, broadcastName: '');
    await player.open(
      Media(
        album.url,
        extras: {
          'surah': album.surah.toJson(),
          'reciter': album.reciter.toJson(),
          'recitationID': album.recitationID,
          'url': album.url,
        },
      ),
    );
  }

  Future<void> playNext() async {
    await player.next();
  }

  bool isLocalAudio() {
    return state.album?.isLocal ?? false;
  }

  Future<void> playPrevious() async {
    await player.previous();
  }

  Future<Album> fetchAlbum({
    required int surahID,
    required int reciterID,
    int? recitationID,
  }) async {
    final surah = await ref.read(fetchChapterByIdProvider(id: surahID).future);
    final reciter = await ref.read(fetchReciterProvider(id: reciterID).future);
    final mixID = createShortHash(surahID, recitationID, reciter.id);

    final audio = await ref.read(
      fetchAudioForChapterProvider(
        chapterNumber: surahID,
        reciterID: reciterID,
        recitationID: recitationID,
      ).future,
    );
    final album = Album(
      surah: surah,
      reciter: reciter,
      url: audio.url,
      recitationID: audio.recitationID,
    );
    await ref
        .read(playerCacheProvider(key: mixID).notifier)
        .setAlbum(album, key: mixID);

    return album;
  }

  String createShortHash(int surahID, int? recitationID, int reciterID) {
    final uniqueData = 'surahID_${surahID}_${recitationID ?? 0},$reciterID';
    final hash = sha256.convert(utf8.encode(uniqueData)).toString();
    return hash.substring(0, 8);
  }

  Future<void> play({required int surahID, int? recitationID}) async {
    state = state.copyWith(broadcastName: '');

    final cacheManager = DefaultCacheManager();
    final chosenReciter = ref.read(userReciterProvider);

    final mixID = createShortHash(surahID, recitationID, chosenReciter.id);
    debugPrint(mixID);
    final cachedFile = await cacheManager.getFileFromCache(mixID);
    final cachedAlbum = ref.read(playerCacheProvider(key: mixID));

    if (cachedAlbum == null) {
      final album = await fetchAlbum(
        surahID: surahID,
        reciterID: chosenReciter.id,
        recitationID: recitationID,
      );
      await player.open(
        Media(
          album.url,
          extras: {
            'surah': album.surah.toJson(),
            'reciter': album.reciter.toJson(),
            'recitationID': album.recitationID,
            'url': album.url,
          },
        ),
      );
      await cacheManager.downloadFile(album.url, key: mixID);
      debugPrint('Cached');
      return;
    }
    debugPrint(cachedFile.toString());
    if (cachedFile != null) {
      debugPrint('Loading from cache');

      final album = Album(
        surah: cachedAlbum.surah,
        reciter: cachedAlbum.reciter,
        url: cachedFile.file.path,
        recitationID: cachedAlbum.recitationID,
      );
      state = state.copyWith(album: album);
      await player.open(
        Media(
          album.url,
          extras: {
            'surah': album.surah.toJson(),
            'reciter': album.reciter.toJson(),
            'recitationID': album.recitationID,
            'url': album.url,
          },
        ),
      );
      return;
    }
    final album = await fetchAlbum(
      surahID: surahID,
      reciterID: chosenReciter.id,
      recitationID: recitationID,
    );

    state = state.copyWith(album: album);
    await player.open(
      Media(
        album.url,
        extras: {
          'surah': album.surah.toJson(),
          'reciter': album.reciter.toJson(),
          'recitationID': album.recitationID,
          'url': album.url,
        },
      ),
    );
    await cacheManager.downloadFile(album.url, key: mixID);
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

  void changePosition(Duration position) {
    state = state.copyWith(position: position);
  }

  Future<void> handleSeek(Duration value) async {
    await player.seek(value);
    state = state.copyWith(position: value);
  }

  Future<void> handleVolume(double value) async {
    await player.setVolume(value * 100);

    state = state.copyWith(volume: value);
  }

  Future<void> addLocalQueue() async {
    final audios = await ref.read(getLocalAudioProvider.future);
    final currentIndex = audios.indexWhere((e) => e.url == state.album!.url);

    if (currentIndex < audios.length) {
      for (var i = currentIndex + 1; i < audios.length; i++) {
        final album = audios[i];

        await player.add(
          Media(
            album.url,
            extras: {
              'surah': album.surah.toJson(),
              'reciter': album.reciter.toJson(),
              'recitationID': album.recitationID,
              'url': album.url,
            },
          ),
        );
      }
    }
  }

  Future<void> addToQueue({int? surahID}) async {
    if (surahID == null) {
      if (state.album != null) {
        final currentID = state.album!.surah.id;
        final queueIDs = currentID + 20;
        if (queueIDs < 114) {
          for (var i = currentID + 1; i < queueIDs; i++) {
            final album = await ref.read(
              fetchAlbumProvider(chapterNumber: i).future,
            );
            final url = album.url;
            await player.add(
              Media(
                url,
                extras: {
                  'surah': album.surah.toJson(),
                  'reciter': album.reciter.toJson(),
                  'recitationID': album.recitationID,
                  'url': url,
                },
              ),
            );
          }
        }
      }
      return;
    }
    final album = await ref.read(
      fetchAlbumProvider(chapterNumber: surahID).future,
    );
    await player.add(
      Media(
        album.url,
        extras: {
          'surah': album.surah.toJson(),
          'reciter': album.reciter.toJson(),
          'recitationID': album.recitationID,
          'url': album.url,
        },
      ),
    );
  }

  Future<void> shuffle() async {
    state = state.copyWith(isShuffle: !state.isShuffle);
    await player.setShuffle(state.isShuffle);
  }

  List<Album> getQueue() {
    final medias = player.state.playlist.medias;
    final extras = medias.map((e) => e.extras).where((e) => e != null).toList();
    return extras.map((e) => Album.fromJson(e!)).toList();
  }

  Future<void> moveItem(int fromIndex, int toIndex) async {
    await player.move(fromIndex, toIndex);
  }

  Future<void> addItemNext(int surahID) async {
    final album = await ref.read(
      fetchAlbumProvider(chapterNumber: surahID).future,
    );
    final lastIndex = state.queue.length;
    await player.add(
      Media(
        album.url,
        extras: {
          'surah': album.surah.toJson(),
          'reciter': album.reciter.toJson(),
          'recitationID': album.recitationID,
          'url': album.url,
        },
      ),
    );
    await player.move(lastIndex, player.state.playlist.index + 1);
  }

  Future<void> playItem(int index) async {
    await player.jump(index);
  }

  Future<void> playBroadcast(String url, String name) async {
    await player.open(Media(url));
    state = state.copyWith(broadcastName: name);
  }

  Future<void> removeItem(int index) async {
    await player.remove(index);
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

  ({String currentTime, String durationTime}) playerTime() {
    final currentTime = formatDuration(state.position);
    final durationTime = formatDuration(state.duration);
    return (currentTime: currentTime, durationTime: durationTime);
  }
}

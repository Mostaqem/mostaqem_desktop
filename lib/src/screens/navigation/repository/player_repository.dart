// ignore_for_file: inference_failure_on_instance_creation

import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:media_kit/media_kit.dart';
import 'package:mostaqem/src/core/discord/discord_provider.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/data/album_utils.dart';
import 'package:mostaqem/src/screens/navigation/data/player.dart';
import 'package:mostaqem/src/screens/navigation/repository/album_repository.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_cache.dart';
import 'package:mostaqem/src/screens/offline/repository/offline_repository.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';
import 'package:mostaqem/src/screens/reciters/providers/reciters_repository.dart';
import 'package:mostaqem/src/shared/internet_checker/network_checker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:windows_taskbar/windows_taskbar.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

part 'player_repository.g.dart';

@riverpod
class PlayerNotifier extends _$PlayerNotifier {
  final player = Player();
  int bufferSize = 3;

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
        debugPrint(cachedSurah.position.toString());
        return audioState.copyWith(
          album: cachedSurah,
          position: Duration(milliseconds: cachedSurah.position),
        );
      }
    }
    return audioState;
  }

  void init() {
    player.stream.playlist.listen((data) {
      if (data.medias.length == 1 && state.broadcastName != null) {
        if (isLocalAudio()) {
          addLocalQueue();
        } else {
          _checkAndPreload(data.index, medias: data.medias);
        }
      }

      state = state.copyWith(
        queueIndex: data.index,
        album: AlbumUtils.parseAlbum(data.index, data),
        nextAlbum: state.album?.surah.id == 114
            ? null
            : AlbumUtils.parseAlbum(data.index + 1, data),
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
      ref
          .read(playerCacheProvider().notifier)
          .setAlbum(
            Album(
              surah: state.album!.surah,
              reciter: state.album!.reciter,
              url: state.album!.url,
              position: position.inMilliseconds,
              recitationID: state.album!.recitationID,
            ),
          );
    });

    player.stream.duration.listen((duration) async {
      state = state.copyWith(duration: duration);
      final cachedAlbum = ref.read(playerCacheProvider());
      if (cachedAlbum != null) {
        final positionAlbum = Duration(milliseconds: cachedAlbum.position);
        debugPrint(positionAlbum.toString());
        await player.seek(positionAlbum);
      }
    });

    player.stream.playing.listen((playing) async {
      state = state.copyWith(isPlaying: playing);

      if (Platform.isWindows) {
        windowThumbnailBar();
      }
      if (state.album != null) {
        if (playing) {
          ref.read(
            updateRPCDiscordProvider(
              url: state.album!.url,
              surahName: state.album!.surah.simpleName,
              reciter: state.album!.reciter.englishName,
            ),
          );
        } else {
          ref.read(clearRPCDiscordProvider);
        }
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

  bool isFirstChapter() => state.queueIndex == 0;

  bool isLastchapter() => state.nextAlbum == null;

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
    await _openAlbum(album, broadcast: '');
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

  Future<void> play({required int surahID, int? recitationID}) async {
    if (state.broadcastName != '') {
      state = state.copyWith(broadcastName: '');
    }

    final cacheManager = DefaultCacheManager();
    final chosenReciter = ref.read(userReciterProvider);

    final mixID = ref
        .read(albumRepositoryProvider)
        .createShortHash(surahID, recitationID, chosenReciter.id);

    // final cachedFile = await cacheManager.getFileFromCache(mixID);
    // final cachedAlbum = ref.read(playerCacheProvider(key: mixID));

    // if (state.queue.contains(cachedAlbum)) {
    //   final index = state.queue.indexWhere((value) => value == cachedAlbum);
    //   await player.jump(index);
    //   return;
    // }

    // debugPrint(cachedFile.toString());
    // if (cachedFile != null) {
    //   debugPrint('Loading from cache');

    //   final album = Album(
    //     surah: cachedAlbum!.surah,
    //     reciter: cachedAlbum.reciter,
    //     url: cachedFile.file.path,
    //     recitationID: cachedAlbum.recitationID,
    //   );
    //   await _openAlbum(album);

    //   return;
    // }
    final networkState = ref.watch(getConnectionProvider).value;
    if (networkState == InternetConnectionStatus.connected) {
      final album = await ref
          .read(albumRepositoryProvider)
          .fetchPlayerAlbum(
            surahID: surahID,
            reciterID: chosenReciter.id,
            recitationID: recitationID,
          );
      await _openAlbum(album);

      if (state.queue.contains(album)) {
        final index = state.queue.indexWhere((value) => value == album);
        await player.jump(index);
        return;
      }

      await _openAlbum(album);
      // await cacheManager.downloadFile(album.url, key: mixID);
    }
  }

  Future<void> playYoutube({required String url, required String title}) async {
    final yt = YoutubeExplode();
    final video = await yt.videos.get(url);
    final manifest = await yt.videos.streams.getManifest(video.id);
    final audio = manifest.audioOnly;
    final audioURL = audio.first.url.toString();
    await player.open(Media(audioURL));
    state = state.copyWith(broadcastName: title);
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

  Future<void> addToQueue({required int surahID}) async {
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

  Future<void> _openAlbum(Album album, {String? broadcast}) async {
    if (broadcast != null) {
      state = state.copyWith(album: album, broadcastName: broadcast);
    } else {
      state = state.copyWith(album: album);
    }
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

  bool isChapterInQueue(int id) {
    return state.queue.any((album) => album.surah.id == id);
  }

  Future<void> _checkAndPreload(
    int currentIndex, {
    required List<Media> medias,
  }) async {
    final remaining = medias.length - (currentIndex + 1);
    if (remaining < bufferSize) {
      final lastSurahId = medias.last.extras?['surah']['id'] as int;

      if (lastSurahId < 114) {
        await _addNextAlbumsBatched(
          bufferSize - remaining,
          startId: lastSurahId + 1,
        );
      }
    }
  }

  Future<void> _addNextAlbumsBatched(int count, {required int startId}) async {
    final maxID = (startId + count).clamp(0, 114);

    final albums = await Future.wait([
      for (var i = startId; i <= maxID; i++)
        ref.read(
          fetchAlbumProvider(
            chapterNumber: i,
            recitationID: state.album?.recitationID,
          ).future,
        ),
    ]);

    for (final album in albums) {
      await _addAlbumToQueue(album);
    }
  }

  Future<void> _addAlbumToQueue(Album album) async {
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

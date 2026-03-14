// ignore_for_file: inference_failure_on_instance_creation

import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:media_kit/media_kit.dart';
import 'package:mostaqem/src/core/SMTC/smtc_provider.dart';
import 'package:mostaqem/src/core/discord/discord_provider.dart';
import 'package:mostaqem/src/core/mpris/mpris_repository.dart';
import 'package:mostaqem/src/core/now_playing/now_playing_manager.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/data/album_utils.dart';
import 'package:mostaqem/src/screens/navigation/data/player.dart';
import 'package:mostaqem/src/screens/navigation/data/queue_utils.dart';
import 'package:mostaqem/src/screens/navigation/repository/album_repository.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_cache.dart';
import 'package:mostaqem/src/screens/offline/repository/offline_repository.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';
import 'package:mostaqem/src/screens/reciters/providers/reciters_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:windows_taskbar/windows_taskbar.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

part 'player_repository.g.dart';



@riverpod
class PlayerNotifier extends _$PlayerNotifier {
  final player = Player();
  int bufferSize = 3;
  bool _hasRestoredPosition = false;

  @override
  AudioState build() {
    final audioState = AudioState();

    init();

    final cachedSurah = ref.read(playerCacheProvider());
    if (cachedSurah != null) {
      player.open(
        Media(
          cachedSurah.url,
          extras: {
            'surah': cachedSurah.surah.toJson(),
            'reciter': cachedSurah.reciter.toJsonDeep(),
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

    return audioState;
  }

  void init() {
    if (Platform.isLinux) {
      MprisManager.instance.init(ref);
    }
    if (Platform.isWindows) {
      SmtcManager.instance.init(this);
    }
    if (Platform.isMacOS) {
      NowPlayingManager.instance.init(this);
    }


    player.stream.playlist.listen((data) {
      if (data.medias.length == 1) {
        if (isLocalAudio()) {
          addLocalQueue();
        } else {
          _checkAndPreload(data.index, medias: data.medias);
        }
      }

      final currentAlbum = AlbumUtils.parseAlbum(data.index, data);
      final nextAlbum = AlbumUtils.parseAlbum(data.index + 1, data);

      state = state.copyWith(
        queueIndex: data.index,
        album: currentAlbum,
        nextAlbum: currentAlbum?.surah.id == 114 ? null : nextAlbum,
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

      if (Platform.isLinux && currentAlbum != null) {
        MprisManager.instance.updateMetadata(
          reciterName: currentAlbum.reciter.name,
          surah: currentAlbum.surah.name,
          url: currentAlbum.url,
          length: state.duration,
        );
      }

      if (Platform.isWindows && currentAlbum != null) {
        SmtcManager.instance.updateMetadata(
          reciterName: currentAlbum.reciter.name,
          surah: currentAlbum.surah.name,
        );
        if (state.duration > Duration.zero) {
          SmtcManager.instance.updateTimeline(
            position: state.position,
            duration: state.duration,
          );
        }
      }

      if (Platform.isMacOS && currentAlbum != null) {
        NowPlayingManager.instance.updateMetadata(
          title: currentAlbum.surah.name,
          artist: currentAlbum.reciter.name,
          duration: state.duration,
        
        );
      }
    });

    player.stream.position.listen((position) {
      state = state.copyWith(position: position);
      if (state.album != null) {
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
      }
       if (Platform.isWindows && state.duration > Duration.zero) {
        SmtcManager.instance.updateTimeline(
          position: position,
          duration: state.duration,
        );
      }
      if (Platform.isMacOS && state.duration > Duration.zero) {
        NowPlayingManager.instance.updatePosition(
          position: position,
          duration: state.duration,
        );
      }
    });

    player.stream.duration.listen((duration) async {
      state = state.copyWith(duration: duration);

      // Update MPRIS metadata with correct duration when it's known
      if (Platform.isLinux && state.album != null && duration > Duration.zero) {
        MprisManager.instance.updateMetadata(
          reciterName: state.album!.reciter.name,
          surah: state.album!.surah.name,
          url: state.album!.url,
          length: duration,
        );
      }
         if (Platform.isWindows &&
          state.album != null &&
          duration > Duration.zero) {
        SmtcManager.instance.updateTimeline(
          position: state.position,
          duration: duration,
        );
      }
      if (Platform.isMacOS && state.album != null && duration > Duration.zero) {
        NowPlayingManager.instance.updateMetadata(
          title: state.album!.surah.name,
          artist: state.album!.reciter.name,
          duration: duration,
        );
      }

      if (!_hasRestoredPosition) {
        final cachedAlbum = ref.read(playerCacheProvider());
        if (cachedAlbum != null) {
          final positionAlbum = Duration(milliseconds: cachedAlbum.position);
          debugPrint(positionAlbum.toString());
          await player.seek(positionAlbum);
        }
        _hasRestoredPosition = true;
      }
    });

    player.stream.playing.listen((playing) async {
      state = state.copyWith(isPlaying: playing);

      if (Platform.isWindows) {
        windowThumbnailBar();
      }

      // Update MPRIS playback status (Linux only)
      if (Platform.isLinux) {
        MprisManager.instance.updatePlaybackStatus(isPlaying: playing);
      }
        if (Platform.isWindows) {
        SmtcManager.instance.updatePlaybackStatus(isPlaying: playing);
      }
      if (Platform.isMacOS) {
        NowPlayingManager.instance.updatePlaybackState(isPlaying: playing);
      }

      if (state.album != null) {
        if (playing) {
          ref.read(
            updateRPCDiscordProvider(
              url: state.album!.url,
              surahName: state.album!.surah.name,
              reciter: state.album!.reciter.name,
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

    final chosenReciter = ref.watch(userReciterProvider);
    print('ChosenReciter: $chosenReciter');

    // // Check if the surah is already in the current queue
    // final existingIndex = state.queue.indexWhere(
    //   (album) => album.surah.id == surahID,
    // );
    // if (existingIndex != -1) {
    //   await player.jump(existingIndex);
    //   return;
    // }

    final album = await ref
        .read(albumRepositoryProvider)
        .fetchPlayerAlbum(
          surahID: surahID,
          reciterID: chosenReciter.id,
          recitationID: recitationID,
        );
    await _openAlbum(album);
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
              'reciter': album.reciter.toJsonDeep(),
              'recitationID': album.recitationID,
              'url': album.url,
            },
          ),
        );
      }
    }
  }

  Future<void> addToQueue({required int surahID}) async {
    if (QueueUtils.isAlbumInQueue(player.state.playlist.medias, surahID)) {
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
          'reciter': album.reciter.toJsonDeep(),
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
    if (QueueUtils.isAlbumInQueue(player.state.playlist.medias, surahID)) {
      return;
    }

    final album = await ref.read(
      fetchAlbumProvider(chapterNumber: surahID).future,
    );
    final lastIndex = state.queue.length;
    await player.add(
      Media(
        album.url,
        extras: {
          'surah': album.surah.toJson(),
          'reciter': album.reciter.toJsonDeep(),
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
          'reciter': album.reciter.toJsonDeep(),
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

    try {
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
    } catch (e, stack) {
      print('Error in _addNextAlbumsBatched: $e');
      print('Stack: $stack');
    }
  }

  Future<void> _addAlbumToQueue(Album album) async {
    if (QueueUtils.isAlbumInQueue(
      player.state.playlist.medias,
      album.surah.id,
    )) {
      return;
    }

    await player.add(
      Media(
        album.url,
        extras: {
          'surah': album.surah.toJson(),
          'reciter': album.reciter.toJsonDeep(),
          'recitationID': album.recitationID,
          'url': album.url,
        },
      ),
    );
  }
}

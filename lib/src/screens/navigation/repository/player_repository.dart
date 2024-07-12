import 'dart:io';

import 'package:media_kit/media_kit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/discord/discord_provider.dart';
import '../../../core/mpris/mpris_repository.dart';
import '../../home/providers/home_providers.dart';
import '../../home/widgets/surah_widget.dart';
import '../data/player.dart';
import '../widgets/player_widget.dart';
import 'package:windows_taskbar/windows_taskbar.dart';

part 'player_repository.g.dart';

@riverpod
class PlayerNotifier extends _$PlayerNotifier {
  @override
  AudioState build() {
    init();
    return AudioState();
  }

  final player = Player();

  void init() async {
    final surah = ref.read(playerSurahProvider);
    player.open(Media(surah.url));
    player.stream.position.listen((position) {
      state = state.copyWith(position: position);
    });
    player.stream.duration.listen((duration) {
      state = state.copyWith(duration: duration);
    });
    player.stream.completed.listen((completed) async {
      if (completed) {
        final surahID = ref.read(surahIDProvider) + 1;

        final reciter = ref.read(reciterProvider);
        if (surahID < 114) {
          await ref
              .read(seekIDProvider(surahID: surahID, reciter: reciter).future);
        } else {
          await ref.read(seekIDProvider(surahID: 1, reciter: reciter).future);
        }
      }
    });
    player.stream.playing.listen((playing) async {
      if (playing) {
        state = state.copyWith(isPlaying: true);
      } else {
        state = state.copyWith(isPlaying: false);
      }
      if (Platform.isWindows) {
        windowThumbnailBar();
      }
      ref.watch(updateRPCDiscordProvider(
          surahName: surah.english,
          reciter: surah.reciter,
          position: state.position.inMilliseconds,
          duration: state.duration.inMilliseconds));
      if (Platform.isLinux) {
        ref.watch(mprisRepositoryProvider).createMetadata(
            reciterName: surah.reciter,
            url: surah.url,
            surah: surah.name,
            image: surah.image,
            position: state.position);
      }
    });

    ref.listen(playerSurahProvider, (_, n) {
      player.playOrPause();
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

  bool isFirstChapter() => ref.watch(surahIDProvider) > 1;

  bool isLastchapter() => ref.watch(surahIDProvider) < 114;

  void handlePlayPause() {
    if (state.isPlaying) {
      player.pause();

      state = state.copyWith(isPlaying: false);
    } else {
      player.play();

      state = state.copyWith(isPlaying: true);
    }
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
          final surahID = ref.read(surahIDProvider) + 1;
          final reciter = ref.read(reciterProvider);
          await ref
              .read(seekIDProvider(surahID: surahID, reciter: reciter).future);
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
          final surahID = ref.read(surahIDProvider) - 1;
          final reciter = ref.read(reciterProvider);
          await ref
              .read(seekIDProvider(surahID: surahID, reciter: reciter).future);
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

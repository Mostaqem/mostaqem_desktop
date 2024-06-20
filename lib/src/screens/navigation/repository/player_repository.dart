import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../../shared/discord/discord_provider.dart';
import '../../home/providers/home_providers.dart';
import '../../home/widgets/surah_widget.dart';
import '../data/player.dart';
import '../widgets/player_widget.dart';
import 'package:windows_taskbar/windows_taskbar.dart';

final playerNotifierProvider =
    StateNotifierProvider.autoDispose<PlayerNotifier, AudioState>(
        PlayerNotifier.new);

class PlayerNotifier extends StateNotifier<AudioState> {
  final Ref ref;
  PlayerNotifier(this.ref) : super(AudioState()) {
    init();
  }

  final player = AudioPlayer();

  void init() {
    final surah = ref.read(playerSurahProvider);
    player.setUrl(surah.url, preload: true);
    player.playerStateStream.listen((event) async {
      if (event.processingState == ProcessingState.ready) {
        if (mounted) {
          if (state.isPlaying) {
            player.play();
          } else {
            player.pause();
          }
        }
        ref.watch(updateRPCDiscordProvider(
          surahName: surah.english,
        ));
        if (Platform.isWindows) {
          windowThumbnailBar();
        }
      }
      if (event.processingState == ProcessingState.completed) {
        final surahID = ref.read(surahIDProvider) + 1;
        final reciter = ref.read(reciterProvider);
        await ref
            .read(seekIDProvider(surahID: surahID, reciter: reciter).future);
      }
    });
    player.positionStream.listen((p) {
      if (mounted) {
        state = state.copyWith(position: p);
      }
    });
    player.durationStream.listen((d) {
      if (mounted) {
        state = state.copyWith(duration: d ?? Duration.zero);
      }
    });

    ref.listen(playerSurahProvider, (p, n) {
      player.setUrl(n.url);
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
      if (mounted) {
        state = state.copyWith(isPlaying: false);
      }
    } else {
      player.play();
      if (mounted) {
        state = state.copyWith(isPlaying: true);
      }
    }
  }

  Future<void> handleSeek(double value) async {
    await player.seek(
      Duration(seconds: value.toInt()),
    );
  }

  void handleVolume(double value) {
    player.setVolume(value);
    if (mounted) {
      state = state.copyWith(volume: value);
    }
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

  (String, String) playerTime() {
    String currentTime = formatDuration(state.position);
    String durationTime = formatDuration(state.duration);
    return (currentTime, durationTime);
  }
}

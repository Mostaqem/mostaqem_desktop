import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/repository/fullscreen_notifier.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_cache.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:window_manager/window_manager.dart';

import 'normal_player.dart';
import 'play_controls.dart';
import 'volume_control.dart';

final playerSurahProvider = StateProvider.autoDispose<Album?>((ref) {
  final cachedSurah = ref.read(playerCacheProvider);
  if (cachedSurah != null) {
    return cachedSurah;
  }

  return null;
});

final isCollapsedProvider = StateProvider<bool>((ref) => false);

class PlayerWidget extends ConsumerStatefulWidget {
  const PlayerWidget({
    super.key,
  });

  @override
  ConsumerState<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends ConsumerState<PlayerWidget>
    with WindowListener {
  Timer? _timer;
  bool _isVisible = true;

  void _resetTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }

    _timer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _isVisible = false;
      });
    });

    setState(() {
      _isVisible = true;
    });
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    _timer?.cancel();
    windowManager.removeListener(this);

    super.dispose();
  }

  @override
  void onWindowClose() {
    final player = ref.watch(playerSurahProvider);
    final position = ref.watch(playerNotifierProvider).position;
    ref.read(playerCacheProvider.notifier).setAlbum(Album(
        surah: player!.surah,
        reciter: player.reciter,
        url: player.url,
        position: position.inMilliseconds));
    super.onWindowClose();
  }

  @override
  Widget build(BuildContext context) {
    bool isFullScreen = ref.watch(isFullScreenProvider);
    return MouseRegion(
      onHover: (event) {
        if (isFullScreen) {
          _resetTimer();
        }
      },
      child: Visibility(
        visible: isFullScreen ? _isVisible : true,
        child: Stack(
          children: [
            Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    color: isFullScreen
                        ? Colors.transparent
                        : Theme.of(context).colorScheme.secondaryContainer),
                child: isFullScreen
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FullScreenPlayControls(
                            ref: ref,
                          ),
                          const Expanded(child: VolumeControls()),
                        ],
                      )
                    : LayoutBuilder(builder: (context, constraints) {
                        return constraints.minWidth < 1285
                            ? FittedBox(
                                child: NormalPlayer(
                                    isFullScreen: isFullScreen, ref: ref))
                            : NormalPlayer(
                                isFullScreen: isFullScreen, ref: ref);
                      })),
            Visibility(
              visible: ref.watch(playerSurahProvider) == null,
              child: MouseRegion(
                cursor: SystemMouseCursors.forbidden,
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryContainer
                          .withOpacity(0.4)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';

import '../../../shared/widgets/text_hover.dart';
import 'player_widget.dart';

class PlayingSurah extends StatelessWidget {
  const PlayingSurah({
    super.key,
    required this.isFullScreen,
    required this.ref,
  });

  final bool isFullScreen;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final player = ref.watch(playerSurahProvider);

    return Visibility(
      visible: !isFullScreen,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      player?.surah.arabicName ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                    ),
                  ),
                  Visibility(
                    visible: !ref
                            .read(playerNotifierProvider.notifier)
                            .isLocalAudio() &&
                        ref.watch(playerSurahProvider) != null,
                    child: IconButton(
                        onPressed: () => ref
                            .read(isCollapsedProvider.notifier)
                            .update((state) => !state),
                        icon: Icon(
                          Icons.arrow_drop_up_outlined,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        )),
                  ),
                ],
              ),
              TextHover(
                text: player?.reciter.arabicName ?? "",
                onTap: () {
                  final isLocalAudio =
                      ref.read(playerNotifierProvider.notifier).isLocalAudio();
                  if (isLocalAudio == false) {
                    ref.read(goRouterProvider).push("/reciters");
                  }
                  return;
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

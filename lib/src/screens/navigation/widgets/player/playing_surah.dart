import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/player_widget.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/recitation_widget.dart';
import 'package:mostaqem/src/shared/widgets/text_hover.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';

class PlayingSurah extends StatelessWidget {
  const PlayingSurah({
    required this.isFullScreen,
    required this.ref,
    super.key,
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
                      player?.surah.arabicName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: ref.watch(playerSurahProvider) != null,
                    child: IconButton(
                      onPressed: () => ref
                          .read(isCollapsedProvider.notifier)
                          .update((state) => !state),
                      icon: Icon(
                        Icons.arrow_drop_up_outlined,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
              TextHover(
                text: player?.reciter.arabicName ?? '',
                onTap: () {
                  final isLocalAudio =
                      ref.read(playerNotifierProvider.notifier).isLocalAudio();

                  if (isLocalAudio == false) {
                    ref.read(goRouterProvider).go('/reciters');

                    return;
                  }

                  return;
                },
              ),
            ],
          ),
          const SizedBox(
            width: 70,
          ),
          ToolTipIconButton(
            message: 'تلاوات',
            onPressed: () {
              final height = ref.read(recitationHeight);
              if (height != 0) {
                ref.read(recitationHeight.notifier).state = 0;
                return;
              }
              ref.read(recitationHeight.notifier).state = 170;
            },
            icon: const Icon(Icons.import_contacts_outlined),
          ),
        ],
      ),
    );
  }
}

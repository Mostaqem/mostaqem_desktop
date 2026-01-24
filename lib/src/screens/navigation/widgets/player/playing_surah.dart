import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/player_widget.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/recitation_widget.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/shared/widgets/scrolling_text.dart';
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
    final surah = ref.watch(currentSurahProvider);
    final reciter = ref.watch(currentReciterProvider);
    final locale = ref.watch(localeProvider).languageCode;
    return Visibility(
      visible: !isFullScreen,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  surah?.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  final isLocalAudio = ref.read(isLocalProvider);

                  if (isLocalAudio == false) {
                    final canPop = ref
                        .read(navigationProvider)
                        .canPop(expectedPath: '/reciters');
                    if (canPop) {
                      ref.read(goRouterProvider).pop();
                      return;
                    }
                    ref.read(goRouterProvider).push('/reciters');

                    return;
                  }

                  return;
                },
                child: MouseRegion(
                  cursor: !ref.watch(isLocalProvider)
                      ? SystemMouseCursors.click
                      : SystemMouseCursors.basic,
                  child: ScrollingText(
                    text: reciter?.name ?? '',
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSecondaryContainer.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 50),
          ToolTipIconButton(
            message: context.tr.playlist,
            iconSize: 20,
            onPressed: () {
              ref.read(isCollapsedProvider.notifier).update((state) => !state);
            },
            icon: const Icon(Icons.playlist_play),
          ),
          const SizedBox(width: 10),
          Visibility(
            visible: !ref.read(isLocalProvider),
            child: ToolTipIconButton(
              message: context.tr.recitations,
              iconSize: 16,
              onPressed: () {
                final height = ref.read(recitationHeight);
                if (height != 0) {
                  ref.read(recitationHeight.notifier).state = 0;
                  return;
                }
                ref.read(recitationHeight.notifier).state = 53;
              },
              icon: const Icon(Icons.import_contacts_outlined),
            ),
          ),
        ],
      ),
    );
  }
}

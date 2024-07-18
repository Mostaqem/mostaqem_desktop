import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/routes/routes.dart';

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
                  Text(
                    player.surah.arabicName,
                    style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer),
                  ),
                  IconButton(
                      onPressed: () => ref
                          .read(isCollapsedProvider.notifier)
                          .update((state) => !state),
                      icon: Icon(
                        Icons.arrow_drop_up_outlined,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      )),
                ],
              ),
              TextHover(
                text: player.reciter.arabicName,
                onTap: () {
                  ref.read(goRouterProvider).push("/reciters");
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}


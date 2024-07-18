import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/home/widgets/surah_widget.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player_widget.dart';
import 'package:mostaqem/src/screens/reciters/providers/reciters_repository.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';

import '../../shared/widgets/back_button.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../shared/widgets/window_buttons.dart';

class RecitersScreen extends ConsumerWidget {
  const RecitersScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reciters = ref.watch(fetchRecitersProvider);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WindowButtons(),
          const SizedBox(
            height: 10,
          ),
          const Align(alignment: Alignment.topLeft, child: AppBackButton()),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "اختيار الشيخ",
              style: TextStyle(fontSize: 22),
            ),
          ),
          AsyncWidget(
              value: reciters,
              data: (data) {
                return Expanded(
                  child: SizedBox(
                    child: ListView.separated(
                      itemCount: data.length,
                      separatorBuilder: (context, index) => const Divider(),
                      cacheExtent: 50,
                      itemBuilder: (context, index) {
                        return Consumer(builder: (context, ref, child) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                            data[index].image!)),
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              title: Text(data[index].arabicName),
                              trailing: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ToolTipIconButton(
                                      message: "اختيار الشيخ للتالي",
                                      onPressed: () {
                                        ref
                                            .read(reciterProvider.notifier)
                                            .state = data[index];
                                      },
                                      icon: const Icon(
                                          Icons.queue_play_next_outlined)),
                                  const VerticalDivider(),
                                  ToolTipIconButton(
                                      message: "اختيار الشيخ",
                                      onPressed: () {
                                        final player =
                                            ref.read(playerSurahProvider);

                                        ref
                                            .read(reciterProvider.notifier)
                                            .state = data[index];

                                        ref
                                            .read(
                                                playerNotifierProvider.notifier)
                                            .play(
                                              surahID: player.surah.id,
                                            );
                                      },
                                      icon: const Icon(Icons.play_arrow)),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                );
              }),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}

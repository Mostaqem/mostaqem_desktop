import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/home/widgets/surah_widget.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/reciters/providers/reciters_repository.dart';
import 'package:mostaqem/src/screens/reciters/providers/search_notifier.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';
import 'package:mostaqem/src/shared/widgets/back_button.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';
import 'package:mostaqem/src/shared/widgets/window_buttons.dart';

import 'package:mostaqem/src/screens/reciters/providers/default_reciter.dart';

class RecitersScreen extends ConsumerWidget {
  RecitersScreen({super.key});
  final queryController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reciters = ref.watch(fetchRecitersProvider);
    final isTyping =
        ref.watch(searchNotifierProvider('reciter'))?.isEmpty ?? false;
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
              'اختيار الشيخ',
              style: TextStyle(fontSize: 22),
            ),
          ),
          Align(
            child: SearchBar(
              controller: queryController,
              onChanged: (value) async {
                ref
                    .read(searchNotifierProvider('reciter').notifier)
                    .setQuery(value);
              },
              elevation: const WidgetStatePropertyAll<double>(0),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              trailing: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: isTyping
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            ref
                                .read(
                                  searchNotifierProvider('reciter').notifier,
                                )
                                .clear();
                            queryController.clear();
                          },
                        )
                      : const Icon(Icons.search),
                ),
              ],
              hintText: 'بحث عن الشيخ...',
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          AsyncWidget(
            value: reciters,
            data: (data) {
              return SizedBox(
                height: MediaQuery.sizeOf(context).height - 250,
                child: ListView.separated(
                  itemCount: data.length,
                  separatorBuilder: (context, index) => const Divider(),
                  cacheExtent: 50,
                  itemBuilder: (context, index) {
                    return Consumer(
                      builder: (context, ref, child) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    data[index].image!,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            title: Text(data[index].arabicName),
                            trailing: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Tooltip(
                                  message: 'اختيار الشيخ افتراضي',
                                  preferBelow: false,
                                  child: Radio(
                                    value: ref.watch(defaultReciterProvider).id,
                                    onChanged: (value) {
                                      final player =
                                          ref.read(playerSurahProvider);
                                      ref
                                          .read(defaultReciterProvider.notifier)
                                          .setDefault(data[index]);
                                      ref.read(reciterProvider.notifier).state =
                                          data[index];
                                      ref
                                          .read(playerNotifierProvider.notifier)
                                          .play(
                                            surahID: player!.surah.id,
                                          );
                                     },
                                    groupValue: data[index].id,
                                  ),
                                ),
                                ToolTipIconButton(
                                  message: 'اختيار الشيخ للتالي',
                                  onPressed: () {
                                    ref.read(reciterProvider.notifier).state =
                                        data[index];
                                  },
                                  icon: const Icon(
                                    Icons.queue_play_next_outlined,
                                  ),
                                ),
                                const VerticalDivider(),
                                ToolTipIconButton(
                                  message: 'اختيار الشيخ',
                                  onPressed: () {
                                    final player =
                                        ref.read(playerSurahProvider);

                                    ref.read(reciterProvider.notifier).state =
                                        data[index];
                                    ref
                                        .read(playerNotifierProvider.notifier)
                                        .play(
                                          surahID: player!.surah.id,
                                        );
                                  },
                                  icon: const Icon(Icons.play_arrow),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}

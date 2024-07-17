import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/home/widgets/surah_widget.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player_widget.dart';
import 'package:mostaqem/src/screens/reciters/providers/reciters_repository.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';

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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: GridView.builder(
                        itemCount: data.length,
                        cacheExtent: 50,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200),
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Consumer(builder: (context, ref, child) {
                              return Card(
                                  child: InkWell(
                                onTap: () {
                                  final player = ref.read(playerSurahProvider);

                                  ref.read(reciterProvider.notifier).state =
                                      data[index];

                                  ref
                                      .read(playerNotifierProvider.notifier)
                                      .play(
                                        surahID: player.surah.id,
                                      );
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Column(
                                  children: [
                                    CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        height: 120,
                                        width: 200,
                                        imageUrl: data[index].image!),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(data[index].arabicName)
                                  ],
                                ),
                              ));
                            }),
                          );
                        },
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}

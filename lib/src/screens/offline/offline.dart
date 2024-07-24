import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player_widget.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';

import 'repository/offline_repository.dart';

class DownloadsScreen extends ConsumerWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localAudio = ref.watch(getLocalAudioProvider);
    return AsyncWidget(
        value: localAudio,
        data: (data) {
          return ListView.separated(
              itemCount: data.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(data[index].surah.arabicName),
                    subtitle: Text(data[index].reciter.arabicName),
                    trailing: ToolTipIconButton(
                        message: "تشغيل",
                        onPressed: () {
                          ref.read(playerSurahProvider.notifier).state =
                              data[index];

                          ref
                              .read(playerNotifierProvider.notifier)
                              .player
                              .play();
                        },
                        icon: const Icon(Icons.play_arrow)));
              });
        });
  }
}

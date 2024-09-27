// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/offline/repository/offline_repository.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';

class DownloadsScreen extends ConsumerWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: Consumer(
            builder: (context, ref, child) {
              final localAudio = ref.watch(getLocalAudioProvider);

              return AsyncWidget(
                value: localAudio,
                data: (data) {
                  if (data.isEmpty) {
                    return Center(
                      child: SvgPicture.asset(
                        'assets/img/empty_box.svg',
                        width: 220,
                        colorFilter: ColorFilter.mode(
                          const Color.fromARGB(255, 202, 197, 197)
                              .withOpacity(0.5),
                          BlendMode.modulate,
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    itemCount: data.length,
                    separatorBuilder: (context, _) => const Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(data[index].surah.arabicName),
                        subtitle: Text(data[index].reciter.arabicName),
                        trailing: ToolTipIconButton(
                          message: 'تشغيل',
                          onPressed: () {
                            ref.read(playerNotifierProvider.notifier).localPlay(
                                  album: data[index].copyWith(isLocal: true),
                                );
                          },
                          icon: const Icon(Icons.play_arrow),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}

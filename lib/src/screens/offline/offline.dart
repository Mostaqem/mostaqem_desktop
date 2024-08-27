import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/player_widget.dart';
import 'package:mostaqem/src/screens/offline/repository/offline_repository.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';

class DownloadsScreen extends ConsumerWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localAudio = ref.watch(getLocalAudioProvider);
    return Column(
      children: [
        Expanded(
          child: AsyncWidget(
            value: localAudio,
            data: (data) {
              if (data.isEmpty) {
                return Center(
                  child: SvgPicture.asset(
                    'assets/img/empty_box.svg',
                    width: 220,
                    colorFilter: ColorFilter.mode(
                      const Color.fromARGB(255, 202, 197, 197).withOpacity(0.5),
                      BlendMode.modulate,
                    ),
                  ),
                );
              }
              return ListView.separated(
                itemCount: data.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index].surah.arabicName),
                    subtitle: Text(data[index].reciter.arabicName),
                    trailing: ToolTipIconButton(
                      message: 'تشغيل',
                      onPressed: () {
                        ref.read(playerSurahProvider.notifier).state =
                            data[index];
                      },
                      icon: const Icon(Icons.play_arrow),
                    ),
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

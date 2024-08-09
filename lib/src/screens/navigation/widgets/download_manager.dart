import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/navigation/repository/download_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player_widget.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';

final downloadHeightProvider = StateProvider<double>((ref) => 0);
final downloadSurahProvider = StateProvider<Surah?>((ref) => null);

class DownloadManagerWidget extends ConsumerWidget {
  const DownloadManagerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(downloadAudioProvider)?.count ?? 0;
    final total = ref.watch(downloadAudioProvider)?.total ?? 1;
    final progress = count / total;
    final height = ref.watch(downloadHeightProvider);
    final surah = ref.watch(downloadSurahProvider);
    final isCancelled = ref.watch(cancelTokenProvider).isCancelled;

    return Positioned(
      bottom: 105,
      left: 100,
      child: AnimatedContainer(
        width: 400,
        duration: const Duration(milliseconds: 150),
        height: height,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12),),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          surah?.image! ??
                              'https://img.freepik.com/premium-photo/illustration-mosque-with-crescent-moon-stars-simple-shapes-minimalist-flat-design_217051-15556.jpg',
                          errorListener: (_) {},),
                    ),),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                  child: LinearProgressIndicator(
                value: isCancelled ? 0 : progress,
              ),),
              Visibility(
                visible: height != 0,
                child: isCancelled
                    ? ToolTipIconButton(
                        message: 'تحميل',
                        onPressed: () {
                          ref.invalidate(cancelTokenProvider);

                          final album = ref.read(playerSurahProvider);

                          ref
                              .read(downloadAudioProvider.notifier)
                              .download(album: album!);
                        },
                        icon: const Icon(Icons.download_rounded),)
                    : CloseButton(
                        onPressed: () {
                          ref.read(cancelTokenProvider).cancel();
                          ref.invalidate(downloadAudioProvider);
                          ref.read(downloadHeightProvider.notifier).state = 0;
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

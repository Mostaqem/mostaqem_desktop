import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/shared/widgets/text_hover.dart';

class QueueWidget extends ConsumerWidget {
  const QueueWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queue = ref.watch(playerNotifierProvider).nextAlbum;

    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'تسمع التالي',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                  TextHover(
                    text: 'المزيد',
                    onTap: () {
                      context.push('/queue');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ListTile(
                onTap: () {
                  ref.read(playerNotifierProvider.notifier).playItem(1);
                },
                focusColor: Colors.red,
                contentPadding: EdgeInsets.zero,
                title: Text(queue?.surah.arabicName ?? ''),
                subtitle: Text(queue?.reciter.arabicName ?? ''),
                trailing: const Icon(Icons.play_arrow),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

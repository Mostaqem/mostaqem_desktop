import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/repository/recitation_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/player_widget.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';

final recitationProvider = StateProvider<int?>((ref) {
  final player = ref.watch(playerSurahProvider);
  return player?.recitationID;
});
final recitationHeight = StateProvider<double>((ref) => 0);

class RecitationWidget extends ConsumerWidget {
  const RecitationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerSurahProvider);

    final recitations = ref.watch(
      fetchReciterRecitationProvider(reciterID: player?.reciter.id ?? 1),
    );
    return Positioned(
      bottom: 105,
      right: 80,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        duration: const Duration(milliseconds: 150),
        width: 400,
        height: ref.watch(recitationHeight),
        child: AsyncWidget(
          value: recitations,
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return RadioListTile(
                  title: Text(data[index].name),
                  value: ref.watch(playerSurahProvider)?.recitationID,
                  groupValue: data[index].id,
                  onChanged: (v) {
                    ref.read(playerSurahProvider.notifier).update(
                          (state) =>
                              state?.copyWith(recitationID: data[index].id),
                        );

                    ref.read(playerNotifierProvider.notifier).play(
                          surahID: player?.surah.id ?? 1,
                          recitationID: data[index].id,
                        );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

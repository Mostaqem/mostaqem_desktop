// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/repository/recitation_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';

final recitationProvider = Provider.autoDispose((ref) {
  return ref.watch(currentAlbumProvider)?.recitationID;
});
final recitationHeight = StateProvider<double>((ref) => 0);

class RecitationWidget extends StatelessWidget {
  const RecitationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 105,
      right: 80,
      child: Consumer(
        builder: (context, ref, child) {
          final album = ref.watch(currentAlbumProvider);

          final recitations = ref.watch(
            fetchReciterRecitationProvider(reciterID: album?.reciter.id ?? 1),
          );
          return AsyncWidget(
            value: recitations,
            loading: SizedBox.shrink,
            data: (data) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(8),
                width: 400,
                height: data.length * ref.watch(recitationHeight),
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      title: Text(data[index].name),
                      value: ref.watch(recitationProvider),
                      groupValue: data[index].id,
                      onChanged: (v) {
                        // ignore: invalid_use_of_visible_for_testing_member
                        ref
                            .read(playerNotifierProvider.notifier)
                            .play(
                              surahID: album?.surah.id ?? 1,
                              recitationID: data[index].id,
                            );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

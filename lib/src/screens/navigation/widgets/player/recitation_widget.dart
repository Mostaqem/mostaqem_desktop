// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';

final recitationProvider = Provider((ref) {
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
          final locale = ref.watch(localeProvider).languageCode;
          final recitations = album?.reciter.moshaf ?? [];
          return AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(8),
            width: 400,
            height: recitations.length * ref.watch(recitationHeight),
            child: ListView.builder(
              itemCount: recitations.length,
              itemBuilder: (context, index) {
                return RadioListTile(
                  title: Text(recitations[index].name),
                  value: ref.watch(recitationProvider),
                  groupValue: recitations[index].id,
                  onChanged: (v) {
                    ref
                        .read(playerProvider.notifier)
                        .play(
                          surahID: album?.surah.id ?? 1,
                          recitationID: recitations[index].id,
                        );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

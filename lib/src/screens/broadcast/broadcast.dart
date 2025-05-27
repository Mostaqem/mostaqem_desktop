import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/broadcast/repository/broadcast_repository.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/reciters/providers/search_notifier.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';
import 'package:mostaqem/src/shared/widgets/nework_required_widget.dart';

class BroadcastScreen extends ConsumerWidget {
  const BroadcastScreen({super.key});
  static final queryController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final broadcasts = ref.watch(fetchBroadcastsProvider);
    final currentBroadcast = ref.watch(currentBroadcastProvider);
    final isTyping =
        ref.watch(searchNotifierProvider('broadcast'))?.isEmpty ?? false;

    return NeworkRequiredWidget(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Align(
                child: SearchBar(
                  controller: queryController,
                  onChanged: (value) {
                    ref
                        .read(searchNotifierProvider('broadcast').notifier)
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
                                      searchNotifierProvider(
                                        'broadcast',
                                      ).notifier,
                                    )
                                    .clear();
                                queryController.clear();
                              },
                            )
                          : const Icon(Icons.search),
                    ),
                  ],
                  hintText: 'ماذا تريد ان تسمع؟',
                ),
              ),
              const SizedBox(height: 20),
              AsyncWidget(
                value: broadcasts,
                data: (data) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height - 180,
                    child: ListView.separated(
                      itemCount: data.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text(
                            data[index].name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          selected: data[index].name == currentBroadcast,
                          selectedTileColor: Theme.of(
                            context,
                          ).colorScheme.primaryContainer,
                          selectedColor: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                          trailing: const Icon(Icons.play_arrow),
                          onTap: () {
                            ref
                                .read(playerNotifierProvider.notifier)
                                .playBroadcast(
                                  data[index].url,
                                  data[index].name,
                                );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

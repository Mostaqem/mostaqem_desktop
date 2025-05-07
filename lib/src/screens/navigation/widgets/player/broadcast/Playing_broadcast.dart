import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';

class PlayingBroadcast extends ConsumerWidget {
  const PlayingBroadcast({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final broadcast = ref.watch(currentBroadcastProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(broadcast.toString()),
    );
  }
}

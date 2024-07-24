import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';
import 'providers/reading_providers.dart';

class ReadingScreen extends ConsumerWidget {
  const ReadingScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scripts = ref.watch(fetchUthmaniScriptProvider(surahID: id));
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: AsyncWidget(
                    value: scripts,
                    data: (data) {
                      return ListView.separated(
                          itemCount: data.length,
                          separatorBuilder: (c, i) => const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                                child: Divider(
                                  height: 50,
                                ),
                              ),
                          itemBuilder: (context, index) {
                            return Text(
                              data[index],
                              // textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontSize: 25, fontFamily: ''),
                            );
                          });
                    })),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}

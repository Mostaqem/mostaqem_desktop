import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/shared/widgets/back_button.dart';

import '../../shared/widgets/window_buttons.dart';
import 'providers/reading_providers.dart';

class ReadingScreen extends ConsumerWidget {
  const ReadingScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scripts = ref.watch(fetchUthmaniScriptProvider(surahID: id));
    return Scaffold(
        body: SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const WindowButtons(),
          const SizedBox(
            height: 10,
          ),
          const AppBackButton(),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: scripts.when(
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
                            style: const TextStyle(fontSize: 25),
                          );
                        });
                  },
                  error: (e, s) {
                    log("[Reading Screen| ID($id)]", error: e, stackTrace: s);
                    return const Text("حدث خطأ ما");
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator())),
            ),
          ),
        ],
      ),
    ));
  }
}

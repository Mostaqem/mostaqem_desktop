import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../shared/widgets/window_bar.dart';
import '../navigation/widgets/player_widget.dart';
import 'providers/reading_providers.dart';

class ReadingScreen extends ConsumerWidget {
  const ReadingScreen({super.key, required this.id, required this.surahName});

  final int id;
  final String surahName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scripts = ref.watch(fetchUthmaniScriptProvider(surahID: id));
    return Scaffold(
        body: SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const WindowBarBox(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(18)),
                  child: Tooltip(
                    message: "رجوع",
                    preferBelow: false,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () => context.pop(),
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
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
                              log("[Reading Screen| ID($id)]",
                                  error: e, stackTrace: s);
                              return const Text("حدث خطأ ما");
                            },
                            loading: () => const Center(
                                child: CircularProgressIndicator())),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      width: 70,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          ),
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                      child: Column(
                        children: [
                          Text(
                            "سورة $surahName",
                            style: const TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: PlayerWidget(),
          )
        ],
      ),
    ));
  }
}

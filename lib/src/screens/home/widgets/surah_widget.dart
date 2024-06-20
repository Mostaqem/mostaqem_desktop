import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../providers/home_providers.dart';

final surahIDProvider = StateProvider<int>((ref) {
  return 1;
});

final reciterProvider = StateProvider((ref) => (id: 1, name: "عبدالباسط"));

class SurahWidget extends ConsumerWidget {
  const SurahWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surahs = ref.watch(filterSurahByQueryProvider);
    return switch (surahs) {
      AsyncError(:final error) => Text('Error: $error'),
      AsyncData(:final value) => Expanded(
          child: GridView.builder(
            itemCount: value.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
            ),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Material(
                  child: InkWell(
                    onTap: () async {
                      context.goNamed(
                        'Reading',
                        extra: value[index].id,
                      );
                      final reciter = ref.read(reciterProvider);
                      final currentID = ref.read(surahIDProvider);
                      if (currentID != value[index].id) {
                        await ref.read(seekIDProvider(
                                surahID: value[index].id,
                                reciter: reciter,
                                surahName: value[index].arabicName)
                            .future);
                      }
                    },
                    splashFactory: NoSplash.splashFactory,
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Positioned(
                            left: -70,
                            child: SvgPicture.asset(
                              "assets/img/shape.svg",
                              width: 130,
                              colorFilter: ColorFilter.mode(
                                  Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer
                                      .withOpacity(0.1),
                                  BlendMode.srcIn),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    value[index].arabicName,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    value[index].simpleName,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer
                                            .withOpacity(0.5)),
                                  ),
                                ),
                                const Spacer(),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child:
                                      Consumer(builder: (context, ref, child) {
                                    return Tooltip(
                                      message: "تشغيل",
                                      preferBelow: false,
                                      child: IconButton(
                                          onPressed: () async {
                                            final reciter =
                                                ref.read(reciterProvider);
                                            await ref.read(seekIDProvider(
                                                    surahID: value[index].id,
                                                    reciter: reciter,
                                                    surahSimpleName:
                                                        value[index].simpleName,
                                                    surahName:
                                                        value[index].arabicName)
                                                .future);
                                          },
                                          icon: const Icon(
                                              Icons.play_circle_fill_outlined)),
                                    );
                                  }),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      _ => const Center(child: CircularProgressIndicator()),
    };

    //     loading: () =>
    //         const Center(heightFactor: 15, child: CircularProgressIndicator()));
  }
}

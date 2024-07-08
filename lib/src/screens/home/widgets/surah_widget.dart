import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';

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
    final reciter = ref.watch(reciterProvider);
    return AsyncWidget(
      value: surahs,
      data: (data) => Expanded(
        child: GridView.builder(
          itemCount: data.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
          ),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Material(
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
                                data[index].arabicName,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                data[index].simpleName,
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
                              child: Consumer(builder: (context, ref, child) {
                                return Tooltip(
                                  message: "تشغيل",
                                  preferBelow: false,
                                  child: IconButton(
                                      onPressed: () async {
                                        ref.read(seekIDProvider(
                                                surahID: data[index].id,
                                                reciter: reciter,
                                                image: data[index].image,
                                                surahSimpleName:
                                                    data[index].simpleName,
                                                surahName:
                                                    data[index].arabicName)
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
    );

    //     loading: () =>
    //         const Center(heightFactor: 15, child: CircularProgressIndicator()));
  }
}

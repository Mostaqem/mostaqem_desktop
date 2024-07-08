import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player_widget.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';

import '../../core/routes/routes.dart';
import '../../shared/widgets/hover_builder.dart';
import 'widgets/hijri_date_widget.dart';
import 'widgets/surah_widget.dart';

final isTypingProvider = StateProvider<bool>((ref) => false);

final searchQueryProvider = StateProvider<String>((ref) => '');

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  final queryController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HijriCalendar.setLocal("ar");
    final isTyping = ref.watch(isTypingProvider);
    final surahImage = ref.watch(playerSurahProvider).image;
    return Scaffold(
        body: Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("تاريخ اليوم"),
                const HijriDateWidget(),
                const SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.center,
                    child: SearchBar(
                      controller: queryController,
                      onChanged: (value) async {
                        ref.read(isTypingProvider.notifier).state =
                            value.isNotEmpty;
                        ref.read(searchQueryProvider.notifier).state = value;
                        ref.refresh(filterSurahByQueryProvider).value;
                      },
                      elevation: const WidgetStatePropertyAll<double>(0),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18))),
                      trailing: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: isTyping
                              ? IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    ref
                                        .read(searchQueryProvider.notifier)
                                        .state = "";
                                    queryController.clear();
                                  },
                                )
                              : const Icon(Icons.search),
                        )
                      ],
                      hintText: "ماذا تريد ان تسمع؟",
                    )),
                const SizedBox(
                  height: 18,
                ),
                const SurahWidget(),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Visibility(
          visible: ref.watch(isCollapsedProvider),
          child: Expanded(
              child: Column(
            children: [
              Container(
                height: 450,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: CloseButton(
                            onPressed: () => ref
                                .read(isCollapsedProvider.notifier)
                                .update((state) => !state),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 300,
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                fit: BoxFit.cover, image: NetworkImage(
                                    //TODO:Handle the image
                                    surahImage))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        ref.watch(
                            playerSurahProvider.select((value) => value.name)),
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
                      ),
                      HoverBuilder(builder: (isHovered) {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              ref.read(goRouterProvider).push('/reciters');
                            },
                            child: Text(
                              ref.watch(playerSurahProvider
                                  .select((value) => value.reciter)),
                              style: TextStyle(
                                  fontSize: 17.0,
                                  decoration: isHovered
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                  color: isHovered
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer
                                          .withOpacity(0.5)),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const QueueWidget()
            ],
          )),
        )
      ],
    ));
  }
}

class QueueWidget extends ConsumerWidget {
  const QueueWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reciter =
        ref.watch(playerSurahProvider.select((value) => value.reciter));
    final nextSurah = ref.watch(fetchNextSurahProvider);
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "تسمع التالي",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondaryContainer),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AsyncWidget(
                        loading: const SizedBox.shrink(),
                        value: nextSurah,
                        data: (data) => Text(data.arabicName)),
                    Text(
                      reciter,
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

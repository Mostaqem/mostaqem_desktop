import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/reciters/providers/default_reciter.dart';
import 'package:mostaqem/src/screens/reciters/providers/reciters_repository.dart';
import 'package:mostaqem/src/screens/reciters/providers/search_notifier.dart';
import 'package:mostaqem/src/screens/reciters/providers/showhide_image.dart';
import 'package:mostaqem/src/shared/widgets/back_button.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';
import 'package:mostaqem/src/shared/widgets/window_buttons.dart';
import 'package:universal_platform/universal_platform.dart';

class RecitersScreen extends ConsumerWidget {
  const RecitersScreen({super.key});
  static final queryController = TextEditingController();
  static const pageSize = 20;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchNotifierProvider('reciter'));
    final isTyping =
        ref.watch(searchNotifierProvider('reciter'))?.isEmpty ?? false;
    final isImageHidden = ref.watch(hideReciterImageProvider);
    final defaultReciter = ref.watch(defaultReciterProvider);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WindowButtons(),
          const SizedBox(
            height: 10,
          ),
          const Align(alignment: Alignment.topLeft, child: AppBackButton()),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'الشيخ الافتراضي',
              style: TextStyle(fontSize: 19),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Visibility(
                  visible: !isImageHidden,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          defaultReciter.image ?? '',
                        ),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                title: Text(
                  defaultReciter.arabicName,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ToolTipIconButton(
                      message: 'اختيار الشيخ للتالي',
                      onPressed: () {
                        ref
                            .read(userReciterProvider.notifier)
                            .setReciter(defaultReciter);
                      },
                      icon: const Icon(
                        Icons.queue_play_next_outlined,
                      ),
                    ),
                    VerticalDivider(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    ToolTipIconButton(
                      message: 'اختيار الشيخ',
                      onPressed: () {
                        ref
                            .read(userReciterProvider.notifier)
                            .setReciter(defaultReciter);
                        final surah = ref.read(
                          currentSurahProvider,
                        );
                        ref.read(playerNotifierProvider.notifier).play(
                              surahID: surah!.id,
                            );
                      },
                      icon: const Icon(Icons.play_arrow),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'اختيار الشيخ',
              style: TextStyle(fontSize: 22),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToolTipIconButton(
                message: isImageHidden ? 'تظهير الصور' : 'إخفاء الصور',
                onPressed: () {
                  ref.read(hideReciterImageProvider.notifier).toggle();
                },
                icon: Icon(
                  isImageHidden
                      ? Icons.image_outlined
                      : Icons.hide_image_outlined,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Align(
                child: SearchBar(
                  controller: queryController,
                  onChanged: (value) async {
                    ref
                        .read(searchNotifierProvider('reciter').notifier)
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
                                      searchNotifierProvider('reciter')
                                          .notifier,
                                    )
                                    .clear();
                                queryController.clear();
                              },
                            )
                          : const Icon(Icons.search),
                    ),
                  ],
                  hintText: 'بحث عن الشيخ...',
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final page = index ~/ pageSize + 1;
                final indexInPage = index % pageSize;
                final reciters = ref.watch(
                  fetchRecitersProvider(page: page, query: searchQuery),
                );

                return reciters.when(
                  error: (e, _) {
                    debugPrint('Reciters Error: $e');
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .error
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('حدث خطا ما'),
                      ),
                    );
                  },
                  loading: () {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                  data: (data) {
                    if (indexInPage >= data.length) {
                      return null;
                    }
                    return Consumer(
                      builder: (context, ref, child) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: Visibility(
                              visible: !isImageHidden,
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                      data[indexInPage].image!,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            title: Text(data[indexInPage].arabicName),
                            trailing: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Tooltip(
                                  message: 'اختيار الشيخ افتراضي',
                                  preferBelow: false,
                                  child: Radio(
                                    value: ref.watch(defaultReciterProvider).id,
                                    onChanged: (value) {
                                      ref
                                          .read(defaultReciterProvider.notifier)
                                          .setDefault(
                                            data[indexInPage],
                                          );
                                      final surah = ref.read(
                                        currentSurahProvider,
                                      );
                                      ref
                                          .read(playerNotifierProvider.notifier)
                                          .play(
                                            surahID: surah!.id,
                                          );
                                    },
                                    groupValue: data[indexInPage].id,
                                  ),
                                ),
                                ToolTipIconButton(
                                  message: 'اختيار الشيخ للتالي',
                                  onPressed: () {
                                    ref
                                        .read(userReciterProvider.notifier)
                                        .setReciter(data[indexInPage]);
                                  },
                                  icon: const Icon(
                                    Icons.queue_play_next_outlined,
                                  ),
                                ),
                                const VerticalDivider(),
                                ToolTipIconButton(
                                  message: 'اختيار الشيخ',
                                  onPressed: () {
                                    ref
                                        .read(userReciterProvider.notifier)
                                        .setReciter(data[indexInPage]);
                                    final surah = ref.read(
                                      currentSurahProvider,
                                    );
                                    ref
                                        .read(playerNotifierProvider.notifier)
                                        .play(
                                          surahID: surah!.id,
                                        );
                                  },
                                  icon: const Icon(Icons.play_arrow),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/screens/home/widgets/hijri_date_widget.dart';
import 'package:mostaqem/src/screens/home/widgets/queue_widget.dart';
import 'package:mostaqem/src/screens/home/widgets/surah_widget.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/player_widget.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/reciters/providers/search_notifier.dart';
import 'package:mostaqem/src/shared/widgets/nework_required_widget.dart';
import 'package:mostaqem/src/shared/widgets/shortcuts/shortcuts_focus.dart';
import 'package:mostaqem/src/shared/widgets/text_hover.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  final queryController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HijriCalendar.setLocal('ar');
    final isTyping =
        ref.watch(searchNotifierProvider('home'))?.isEmpty ?? false;
    final surahImage = ref.watch(
      playerNotifierProvider.select((value) => value.album?.surah.image),
    );
    final focusNode = ref.watch(textFieldFocusProvider);

    return NeworkRequiredWidget(
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('تاريخ اليوم'),
                  const HijriDateWidget(),
                  const SizedBox(height: 10),
                  Align(
                    child: SearchBar(
                      focusNode: focusNode,
                      controller: queryController,
                      onTapOutside: (_) {
                        focusNode?.unfocus();
                        ref.read(shortcutsEnabledProvider.notifier).state =
                            true;
                      },
                      onTap: () => ref
                          .read(shortcutsEnabledProvider.notifier)
                          .update((state) => !state),
                      onChanged: (value) {
                        ref
                            .read(searchNotifierProvider('home').notifier)
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
                                            'home',
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
                  const SizedBox(height: 18),
                  const SurahWidget(),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Visibility(
            visible:
                ref.watch(isCollapsedProvider) &&
                !ref.watch(isAlbumEmptyProvider),
            child: Expanded(
              child: Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.54,
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
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              height: MediaQuery.sizeOf(context).height * 0.34,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    surahImage ?? '',
                                    errorListener: (_) =>
                                        const Icon(Icons.broken_image_outlined),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              ref.watch(
                                playerNotifierProvider.select(
                                  (value) =>
                                      value.album?.surah.arabicName ?? '',
                                ),
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondaryContainer,
                              ),
                            ),
                            TextHover(
                              text: ref.watch(
                                playerNotifierProvider.select(
                                  (value) =>
                                      value.album?.reciter.arabicName ?? '',
                                ),
                              ),
                              onTap: () {
                                ref.read(goRouterProvider).go('/reciters');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const QueueWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

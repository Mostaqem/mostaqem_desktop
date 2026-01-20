import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';
import 'package:mostaqem/src/screens/home/widgets/animated_hint_search_bar.dart';
import 'package:mostaqem/src/screens/home/widgets/hijri_date_widget.dart';
import 'package:mostaqem/src/screens/home/widgets/queue_widget.dart';
import 'package:mostaqem/src/screens/home/widgets/search_results.dart';
import 'package:mostaqem/src/screens/home/widgets/surah_widget.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/player_widget.dart';
import 'package:mostaqem/src/screens/reciters/providers/search_notifier.dart';
import 'package:mostaqem/src/shared/widgets/nework_required_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTyping = ref.watch(searchProvider('home'))?.isEmpty ?? false;
    final query = ref.watch(searchProvider('home'));

    return NeworkRequiredWidget(
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: .circular(12),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const .only(left: 18, right: 18, top: 18),
                  child: Stack(
                    alignment: .topCenter,
                    children: [
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(context.tr.today_hijri),
                          const HijriDateWidget(),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: .start,
                            children: [
                              Align(
                                child: AnimatedHintSearchBar(
                                  onChanged: (value) {
                                    ref
                                        .read(searchProvider('home').notifier)
                                        .setQuery(value);
                                  },
                                  trailing: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: isTyping
                                          ? IconButton(
                                              icon: const Icon(Icons.close),
                                              onPressed: () {
                                                ref
                                                    .read(
                                                      searchProvider(
                                                        'home',
                                                      ).notifier,
                                                    )
                                                    .clear();
                                              },
                                            )
                                          : const Icon(Icons.search),
                                    ),
                                  ],
                                  hintTexts: [
                                    context.tr.what_do_you_want_hear,
                                    context.tr.who_want_to_hear,
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          if (query?.isNotEmpty ?? false)
                            const SearchResults()
                          else
                            const SurahWidget(),
                        ],
                      ),
                      // if (ref.watch(dropdownVisibilityProvider) &&
                      //     focusNode!.hasFocus)
                      //   const Positioned(
                      //     top: 110,
                      //     child: RecentSearchesDropdown(),
                      //   ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Visibility(
            visible: ref.watch(isCollapsedProvider),
            child: const QueueWidget(),
          ),
        ],
      ),
    );
  }
}

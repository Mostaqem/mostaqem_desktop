import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';
import 'package:mostaqem/src/screens/home/widgets/hijri_date_widget.dart';
import 'package:mostaqem/src/screens/home/widgets/queue_widget.dart';
import 'package:mostaqem/src/screens/home/widgets/surah_widget.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/player_widget.dart';
import 'package:mostaqem/src/screens/reciters/providers/search_notifier.dart';
import 'package:mostaqem/src/shared/widgets/nework_required_widget.dart';
import 'package:mostaqem/src/shared/widgets/shortcuts/shortcuts_focus.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  final queryController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTyping =
        ref.watch(searchNotifierProvider('home'))?.isEmpty ?? false;

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
                  Text(context.tr.today_hijri),
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
                      hintText: context.tr.what_do_you_want_hear,
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
            visible: ref.watch(isCollapsedProvider),

            child: const QueueWidget(),
          ),
        ],
      ),
    );
  }
}

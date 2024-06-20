import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';

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
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("تاريخ اليوم"),
        const HijriDateWidget(),
        Align(
            alignment: Alignment.center,
            child: SearchBar(
              controller: queryController,
              onChanged: (value) async {
                ref.read(isTypingProvider.notifier).state = value.isNotEmpty;
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
                            ref.read(searchQueryProvider.notifier).state = "";
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
    ));
  }
}

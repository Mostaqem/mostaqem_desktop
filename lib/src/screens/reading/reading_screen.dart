import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/reading/providers/reading_providers.dart';
import 'package:mostaqem/src/screens/reciters/providers/search_notifier.dart';
import 'package:mostaqem/src/shared/widgets/back_button.dart';
import 'package:mostaqem/src/shared/widgets/window_buttons.dart';
import 'package:universal_platform/universal_platform.dart';

class ReadingScreen extends ConsumerWidget {
  const ReadingScreen({required this.surah, super.key});

  final Surah surah;
  static const pageSize = 10;
  static final queryController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTyping =
        ref.watch(searchNotifierProvider('verse'))?.isEmpty ?? false;

    return Scaffold(
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            const WindowButtons(),
            const SizedBox(
              height: 10,
            ),
            const Align(alignment: Alignment.topLeft, child: AppBackButton()),
            const SizedBox(
              height: 10,
            ),
            Align(
              child: SearchBar(
                controller: queryController,
                onChanged: (value) async {
                  ref
                      .read(searchNotifierProvider('verse').notifier)
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
                                    searchNotifierProvider('verse').notifier,
                                  )
                                  .clear();
                              queryController.clear();
                            },
                          )
                        : const Icon(Icons.search),
                  ),
                ],
                hintText: 'بحث عن اية...',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'سورة ${surah.arabicName}',
              textAlign: TextAlign.center,
              style: GoogleFonts.amiri(fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/img/basmalah.png',
              width: 500,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height - 450,
              child: ListView.builder(
                primary: false,
                itemBuilder: (context, index) {
                  final page = index ~/ pageSize + 1;
                  final indexInPage = index % pageSize;
                  final scripts = ref.watch(
                    fetchUthmaniScriptProvider(
                      surahID: surah.id,
                      page: page,
                      query: queryController.text,
                    ),
                  );

                  return scripts.when(
                    data: (data) {
                      if (indexInPage >= data.length) {
                        return null;
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 25,
                          horizontal: 20,
                        ),
                        child: Text(
                          data[indexInPage].verse,
                          // textAlign: TextAlign.center,
                          style: GoogleFonts.amiri(
                            fontSize: 25,
                          ),
                        ),
                      );
                    },
                    error: (e, _) {
                      debugPrint('Error: $e');
                      return const SizedBox.shrink();
                    },
                    loading: () {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 25,
                          horizontal: 20,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
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
      ),
    );
  }
}

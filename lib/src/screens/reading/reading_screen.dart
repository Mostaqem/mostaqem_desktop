import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/reading/providers/reading_providers.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';
import 'package:mostaqem/src/shared/widgets/back_button.dart';
import 'package:mostaqem/src/shared/widgets/window_buttons.dart';

class ReadingScreen extends StatelessWidget {
  const ReadingScreen({required this.surah, super.key});

  final Surah surah;
  @override
  Widget build(BuildContext context) {
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
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/img/border.svg',
                  width: 700,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                Text(
                  'سورة ${surah.arabicName}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.amiri(fontSize: 30),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/img/basmalah.png',
              width: 300,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer(
              builder: (context, ref, child) {
                final scripts = ref.watch(
                  fetchQuranProvider(
                    surahID: surah.id,
                  ),
                );
                return AsyncWidget(
                  value: scripts,
                  data: (data) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text.rich(
                        TextSpan(
                          children: data
                              .map(
                                (e) => TextSpan(
                                  text: e.verse,
                                  style: GoogleFonts.amiri(
                                    fontSize: 25,
                                  ),
                                  children: [
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 10,
                                        ),
                                        child: CircleAvatar(
                                          child: Text(
                                            e.verseNumber
                                                .toString()
                                                .toArabicNumbers,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      // Wrap(
                      //   spacing: 8,
                      //   runSpacing: 18,
                      //   runAlignment: WrapAlignment.center,
                      //   children: data
                      //       .map(
                      //         (e) => Row(
                      //           mainAxisSize: MainAxisSize.min,
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           spacing: 8,
                      //           children: [
                      //             Flexible(
                      //               child: Text(
                      //                 e.verse,
                      //                 style: GoogleFonts.amiri(
                      //                   fontSize: 25,
                      //                 ),
                      //               ),
                      //             ),
                      //             CircleAvatar(
                      //               child: Text(
                      //                 e.verseNumber.toString().toArabicNumbers,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       )
                      //       .toList(),
                      // ),
                    );
                    // return ListView.builder(
                    //   itemCount: data.length,
                    //   itemBuilder: (context, index) {
                    //     return Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //         vertical: 25,
                    //         horizontal: 20,
                    //       ),
                    //       child: Text(
                    //         data[index].verse,
                    //         // textAlign: TextAlign.center,
                    //         style: GoogleFonts.amiri(
                    //           fontSize: 25,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

extension ToArabicNumber on String {
  String get toArabicNumbers {
    const englishNumbers = '0123456789';
    const arabicNumbers = '٠١٢٣٤٥٦٧٨٩';

    var result = this;
    for (var i = 0; i < englishNumbers.length; i++) {
      result = result.replaceAll(englishNumbers[i], arabicNumbers[i]);
    }

    return result;
  }
}

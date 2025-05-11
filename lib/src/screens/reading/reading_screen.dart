import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/reading/providers/reading_providers.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';
import 'package:mostaqem/src/shared/widgets/back_button.dart';
import 'package:mostaqem/src/shared/widgets/window_buttons.dart';
import 'package:vector_graphics/vector_graphics.dart';

class ReadingScreen extends StatelessWidget {
  const ReadingScreen({required this.surah, super.key});

  final Surah surah;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    VectorGraphic(
                      loader: const AssetBytesLoader(
                        'assets/img/svg/border.svg',
                      ),
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    Text(
                      'سورة ${surah.arabicName}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.amiri(fontSize: 40),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Image.asset(
                  surah.id != 9
                      ? 'assets/img/basmalah.png'
                      : 'assets/img/a3ooz.png',
                  width: 300,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, child) {
                    final scripts = ref.watch(
                      fetchQuranProvider(surahID: surah.id),
                    );
                    return AsyncWidget(
                      value: scripts,
                      error: (e, s) {
                        return Text('Error: $e| ST: $s');
                      },
                      data: (data) {
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text.rich(
                            textAlign: TextAlign.justify,
                            TextSpan(
                              children:
                                  data
                                      .map(
                                        (e) => TextSpan(
                                          text: e.verse,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                            context.push("/share",extra: e.verse);
                                            },
                                          style: GoogleFonts.amiri(
                                            fontSize: 30,
                                            height: 3.2,
                                          ),
                                          children: [
                                            const WidgetSpan(
                                              child: SizedBox(
                                                width: 15,
                                                height: 50,
                                              ),
                                            ),
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      e.verseNumber
                                                          .toString()
                                                          .toArabicNumbers,
                                                  style: GoogleFonts.amiri(
                                                    color:
                                                        Theme.of(
                                                          context,
                                                        ).colorScheme.primary,
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ],
                                              text: '۝',
                                              style: GoogleFonts.amiri(
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).colorScheme.primary,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            const WidgetSpan(
                                              child: SizedBox(
                                                width: 15,
                                                height: 50,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
          Container(
            height: 100,
            color: Theme.of(context).colorScheme.surface,
            child: const Column(
              children: [
                WindowButtons(),
                SizedBox(height: 10),
                Align(alignment: Alignment.topLeft, child: AppBackButton()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension ArabicNumbers on String {
  String get toArabicNumbers {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    var text = this;
    for (var i = 0; i < english.length; i++) {
      text = text.replaceAll(english[i], arabic[i]);
    }
    return text;
  }
}

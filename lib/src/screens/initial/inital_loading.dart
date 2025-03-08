// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mostaqem/src/core/theme/theme.dart';
import 'package:mostaqem/src/screens/initial/data/loading_verse.dart';
import 'package:mostaqem/src/screens/settings/appearance/providers/apperance_providers.dart';
import 'package:mostaqem/src/screens/settings/appearance/providers/theme_notifier.dart';

class InitialLoading extends ConsumerWidget {
  InitialLoading({super.key});
  final randomVerses = <LoadingVerse>[
    LoadingVerse(
      verse: 'وَكَانَ فَضْلُ اللَّهِ عَلَيْكَ عَظِيمًا',
      surah: 'النساء',
      verseNumber: '113',
    ),
    LoadingVerse(
      verse: 'فَمَن يَنصُرُنِي مِنَ اللَّهِ إِنْ عَصَيْتُهُ',
      surah: 'هود',
      verseNumber: '63',
    ),
    LoadingVerse(
      verse: 'رَبِّ فَلَا تَجْعَلْنِي فِي الْقَوْمِ الظَّالِمِينَ',
      surah: 'المؤمنون',
      verseNumber: '94',
    ),
    LoadingVerse(
      verse: 'رَبَّنَا أَفْرِغْ عَلَيْنَا صَبْرًا وَتَوَفَّنَا مُسْلِمِينَ',
      surah: 'الاعراف',
      verseNumber: '126',
    ),
    LoadingVerse(
      verse:
          'وَإِنِّي لَغَفَّارٌ لِّمَن تَابَ وَآمَنَ وَعَمِلَ صَالِحًا ثُمَّ اهْتَدَى',
      surah: 'البقرة',
      verseNumber: '82',
    ),
    LoadingVerse(
      verse: 'أَلاَ بِذِكْرِ اللَهِ تَطْمَئِنُ الْقُلُوبُ',
      surah: 'الرعد',
      verseNumber: '28',
    ),
    LoadingVerse(
      verse: 'وَاغْفِرْ لِأَبِي',
      surah: 'الشعراء',
      verseNumber: '86',
    ),
    LoadingVerse(
      verse: 'رَبَّنَا تَقَبَّلْ مِنَّا إِنَّكَ أَنْتَ السَّمِيعُ الْعَلِيمُ',
      surah: 'البقرة',
      verseNumber: '127',
    ),
    LoadingVerse(
      verse: 'حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ',
      surah: 'آل عمران',
      verseNumber: '173',
    ),
    LoadingVerse(
      verse: 'وَارْزُقْنَا وَأَنْتَ خَيْرُ الرَّازِقِينَ',
      surah: 'المائدة',
      verseNumber: '114',
    ),
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final randomVerse = (randomVerses..shuffle()).first;
    final userColor = ref.watch(userSeedColorProvider);
    final userTheme = ref.watch(themeNotifierProvider);
    return MaterialApp(
      themeMode: userTheme,
      theme: AppTheme.userLightTheme(userColor),
      darkTheme: AppTheme.userDarkTheme(userColor),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SvgPicture.asset(
                  'assets/img/logo.svg',
                  width: 100,
                  colorFilter: ColorFilter.mode(
                    AppTheme.userLightTheme(userColor).colorScheme.primary,
                    BlendMode.color,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                randomVerse.verse,
                style: GoogleFonts.amiri(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text('${randomVerse.surah} : ${randomVerse.verseNumber}'),
              const SizedBox(height: 100),
              const CircularProgressIndicator(),
              const Spacer(),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'مستقيم 2.2.1',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

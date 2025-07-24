import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/occasions/domain/occasions_repository.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';
import 'package:mostaqem/src/shared/widgets/hover_builder.dart';

class OccasionsScreen extends StatefulWidget {
  const OccasionsScreen({super.key});

  @override
  State<OccasionsScreen> createState() => _OccasionsScreenState();
}

class _OccasionsScreenState extends State<OccasionsScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
      height: MediaQuery.sizeOf(context).height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Consumer(
                    builder: (context, ref, child) {
                      final specialRepo = ref.watch(occasionsRepoProvider);
                      final name = specialRepo.todayDayName();
                      return Text(
                        name ?? 'لا يوجد يوم مميز اليوم',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            Center(
              child: SelectableText(
                '" إِنَّ عِدَّةَ الشُّهُورِ عِندَ اللَّهِ اثْنَا عَشَرَ شَهْرًا فِي كِتَابِ اللَّهِ يَوْمَ خَلَقَ السَّمَاوَاتِ وَالْأَرْضَ مِنْهَا أَرْبَعَةٌ حُرُمٌ ۚ ذَٰلِكَ الدِّينُ الْقَيِّمُ ۚ فَلَا تَظْلِمُوا فِيهِنَّ أَنفُسَكُمْ ۚ وَقَاتِلُوا الْمُشْرِكِينَ كَافَّةً كَمَا يُقَاتِلُونَكُمْ كَافَّةً ۚ وَاعْلَمُوا أَنَّ اللَّهَ مَعَ الْمُتَّقِينَ" ',
                textAlign: TextAlign.center,

                style: GoogleFonts.amiri(
                  fontSize: 23,
                  letterSpacing: 0.8,
                  height: 3,
                ),
              ),
            ),
            Center(
              child: SelectableText(
                '- التوبة (36) -',
                textAlign: TextAlign.center,
                style: GoogleFonts.amiri(fontSize: 17),
              ),
            ),
            const Text(
              'نرشح لك بعض السور:',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Consumer(
              builder: (context, ref, child) {
                final surahs = ref.watch(specialSurahsProvider);
                return AsyncWidget(
                  value: surahs,
                  data: (data) {
                    return Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: data.map((surah) {
                        return ContextMenuRegion(
                          contextMenu: GenericContextMenu(
                            buttonConfigs: [
                              ContextMenuButtonConfig(
                                'تشغيل',
                                onPressed: () async {
                                  await ref
                                      .read(playerNotifierProvider.notifier)
                                      .play(surahID: surah.id);
                                },
                              ),
                              ContextMenuButtonConfig(
                                'قراءة السورة',
                                onPressed: () =>
                                    context.pushNamed('Reading', extra: surah),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () async {
                              await ref
                                  .read(playerNotifierProvider.notifier)
                                  .play(surahID: surah.id);
                            },
                            child: HoverBuilder(
                              builder: (isHovered) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  padding: const EdgeInsets.all(8),
                                  width: 130,
                                  height: 100,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isHovered
                                        ? Theme.of(context).colorScheme.tertiary
                                        : Theme.of(
                                            context,
                                          ).colorScheme.tertiaryContainer,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    surah.arabicName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: isHovered
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.onTertiary
                                          : Theme.of(
                                              context,
                                            ).colorScheme.onTertiaryContainer,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

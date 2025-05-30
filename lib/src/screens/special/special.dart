import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/special/domain/special_repository.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';
import 'package:mostaqem/src/shared/widgets/hover_builder.dart';

class SpecialScreen extends StatefulWidget {
  const SpecialScreen({super.key});

  @override
  State<SpecialScreen> createState() => _SpecialScreenState();
}

class _SpecialScreenState extends State<SpecialScreen> {
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
                      final specialRepo = ref.watch(specialRepoProvider);
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
                Align(
                  alignment: Alignment.topLeft,
                  child: Lottie.network(
                    'https://lottie.host/a2a8fd85-faf8-4eae-9803-3f46d1133d5f/ZiTWkvGCtC.json',
                    repeat: true,
                    renderCache: RenderCache.raster,
                    height: 250,
                  ),
                ),
              ],
            ),

            Center(
              child: SelectableText(
                '" وَالْفَجْرِ، وَلَيَالٍ عَشْرٍ " ',
                style: GoogleFonts.amiri(fontSize: 23),
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width - 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                'قال النبي عن فضل العشر الأوائل من شهر ذي الحجة: (ما من أيام العمل الصالح فيهن أحب إلى الله من هذه الأيام العشر، فقالوا: يا رسول الله، ولا الجهاد في سبيل الله؟ قال: ولا الجهاد في سبيل الله، إلا رجل خرج بنفسه وماله فلم يرجع من ذلك بشيء)، رواه الترمذي، وأصله في البخاري.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Center(
              child: Consumer(
                builder: (context, ref, child) {
                  if (loading) {
                    return ElevatedButton.icon(
                      onPressed: () {},
                      label: const Text('لبيك اللهم لبيك'),
                      icon: const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 1),
                      ),
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        const url =
                            'https://www.youtube.com/watch?v=1I1u2Jw_W44&t=2s';
                        await ref
                            .read(playerNotifierProvider.notifier)
                            .playYoutube(url: url, title: 'لبيك اللهم لبيك');
                        setState(() {
                          loading = false;
                        });
                      },
                      child: const Text('لبيك اللهم لبيك'),
                    );
                  }
                },
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

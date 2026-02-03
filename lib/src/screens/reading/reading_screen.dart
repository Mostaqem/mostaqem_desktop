import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/navigation/repository/fullscreen_notifier.dart';
import 'package:mostaqem/src/screens/reading/data/script.dart';
import 'package:mostaqem/src/screens/reading/providers/reading_providers.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';
import 'package:mostaqem/src/shared/widgets/back_button.dart';

class ReadingScreen extends ConsumerWidget {
  const ReadingScreen({required this.surah, super.key});

  final Surah surah;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(surah.id);
    final scripts = ref.watch(fetchQuranProvider(surahID: surah.id));
    final isFullscreen = ref.watch(isFullScreenProvider);
    return Scaffold(
      body: SizedBox(
        height: isFullscreen ? MediaQuery.heightOf(context) - 200 : null,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: double.infinity,
              margin: const .only(top: 70, left: 16, right: 16, bottom: 100),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: .circular(12),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 100),

                    Image.asset(
                      surah.id != 9
                          ? 'assets/img/basmalah.png'
                          : 'assets/img/a3ooz.png',
                      width: 300,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 20),
                    AsyncWidget(
                      value: scripts,
                      error: (e, s) {
                        if (kDebugMode) {
                          return Text('Error: $e| ST: $s');
                        }
                        return const Center(child: Text('Error'));
                      },
                      data: (data) {
                        return VerseSpan(surah: surah, data: data);
                      },
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(16), child: AppBackButton()),
          ],
        ),
      ),
    );
  }
}

class VerseSpan extends StatefulWidget {
  const VerseSpan({required this.data, required this.surah, super.key});

  final List<Script> data;
  final Surah surah;

  @override
  State<VerseSpan> createState() => _VerseSpanState();
}

class _VerseSpanState extends State<VerseSpan> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Consumer(
        builder: (context, ref, child) {
          return SelectableText.rich(
            textAlign: TextAlign.justify,
            onSelectionChanged: (selection, cause) {},
            contextMenuBuilder: (context, editableTextState) {
              final buttonItems = <ContextMenuButtonItem>[
                ContextMenuButtonItem(
                  label: 'نشر الآية',
                  type: ContextMenuButtonType.share,
                  onPressed: () {
                    final selectedText = editableTextState
                        .textEditingValue
                        .selection
                        .textInside(editableTextState.textEditingValue.text);

                    if (selectedText.isNotEmpty) {
                      ref
                          .read(goRouterProvider)
                          .pushNamed(
                            'Share',
                            extra: selectedText.replaceAll('￼', ''),
                            pathParameters: {'surahName': widget.surah.name},
                          );
                    }
                    editableTextState.hideToolbar();
                  },
                ),
              ];
              return AdaptiveTextSelectionToolbar.buttonItems(
                anchors: editableTextState.contextMenuAnchors,
                buttonItems: buttonItems,
              );
            },
            TextSpan(
              children: widget.data
                  .map(
                    (e) => TextSpan(
                      text: e.verse.replaceAll('￼', ''),
                      style: GoogleFonts.amiri(
                        fontSize: 30,
                        height: 3.2,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.pushNamed(
                            'Share',
                            extra: e.verse.replaceAll('￼', ''),
                            pathParameters: {'surahName': widget.surah.name},
                          );
                        },
                      children: [
                        const WidgetSpan(child: SizedBox(width: 23)),
                        TextSpan(
                          children: [
                            TextSpan(
                              text: e.verseNumber.toString().toArabicNumbers,
                              style: GoogleFonts.amiri(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                          text: '۝',
                          style: GoogleFonts.amiri(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const WidgetSpan(
                          child: SizedBox(width: 15, height: 50),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          );
        },
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

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/reading/data/script.dart';
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
                        return VerseSpan(surah: surah, data: data);
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
            child: Column(
              children: [
                const WindowButtons(),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Tooltip(
                        message: 'حدد الآية للمشاركة',
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.info,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const AppBackButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
                            pathParameters: {
                              'surahName': widget.surah.arabicName,
                            },
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
              children:
                  widget.data
                      .map(
                        (e) => TextSpan(
                          text: e.verse.replaceAll('￼', ''),
                          style: GoogleFonts.amiri(
                            fontSize: 30,
                            height: 3.2,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  context.pushNamed(
                                    'Share',
                                    extra: e.verse.replaceAll('￼', ''),
                                    pathParameters: {
                                      'surahName': widget.surah.arabicName,
                                    },
                                  );
                                },
                          children: [
                            const WidgetSpan(child: SizedBox(width: 23)),
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      e.verseNumber.toString().toArabicNumbers,
                                  style: GoogleFonts.amiri(
                                    color:
                                        Theme.of(context).colorScheme.primary,
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mostaqem/src/screens/navigation/repository/lyrics_repository.dart';
import 'package:mostaqem/src/screens/reading/reading_screen.dart';

/// A scrollable lyrics widget that displays all lyrics with the current line highlighted
class ScrollableLyricsView extends ConsumerStatefulWidget {
  const ScrollableLyricsView({super.key});

  @override
  ConsumerState<ScrollableLyricsView> createState() =>
      _ScrollableLyricsViewState();
}

class _ScrollableLyricsViewState extends ConsumerState<ScrollableLyricsView> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _ayahKeys = {};

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentAyah(int index) {
    if (!_ayahKeys.containsKey(index)) return;

    final key = _ayahKeys[index];
    final context = key?.currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.4,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scriptsAsync = ref.watch(surahScriptsProvider);
    final currentIndex = ref.watch(currentAyahIndexProvider);

    return scriptsAsync.when(
      data: (scripts) {
        if (scripts == null || scripts.isEmpty) {
          return Center(
            child: Text(
              'No lyrics available',
              style: GoogleFonts.amiri(
                fontSize: 20,
                color: theme.colorScheme.onPrimaryContainer.withOpacity(0.5),
              ),
            ),
          );
        }

        for (var i = 0; i < scripts.length; i++) {
          _ayahKeys.putIfAbsent(i, GlobalKey.new);
        }

        final activeScriptIndex = currentIndex >= 0
            ? scripts.indexWhere((s) => s.verseNumber == currentIndex)
            : -1;
        if (activeScriptIndex >= 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToCurrentAyah(activeScriptIndex);
          });
        }

        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.heightOf(context) / 2.5,
              horizontal: 40,
            ),
            itemCount: scripts.length,
            itemBuilder: (context, index) {
              final script = scripts[index];
              final isActive = script.verseNumber == currentIndex;

              return Padding(
                key: _ayahKeys[index],
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  style: TextStyle(
                    fontFamily: 'Uthmani',
                    fontWeight: isActive ? FontWeight.w900 : FontWeight.w600,
                    fontSize: isActive ? 54 : 24,
                    color: isActive
                        ? theme.colorScheme.surface
                        : theme.colorScheme.surface.withOpacity(0.4),
                    height: 1.8,
                  ),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: script.verse),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: script.verseNumber.toString().toArabicNumbers,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => Center(
        child: CircularProgressIndicator(color: theme.colorScheme.primary),
      ),
      error: (error, stack) => Center(
        child: Text(
          'Error loading lyrics',
          style: GoogleFonts.amiri(
            fontSize: 20,
            color: theme.colorScheme.error,
          ),
        ),
      ),
    );
  }
}

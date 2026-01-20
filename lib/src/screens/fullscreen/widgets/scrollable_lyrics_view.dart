import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mostaqem/src/screens/navigation/repository/lyrics_repository.dart';

/// A scrollable lyrics widget that displays all lyrics with the current line highlighted
class ScrollableLyricsView extends ConsumerStatefulWidget {
  const ScrollableLyricsView({super.key});

  @override
  ConsumerState<ScrollableLyricsView> createState() =>
      _ScrollableLyricsViewState();
}

class _ScrollableLyricsViewState extends ConsumerState<ScrollableLyricsView> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _lyricKeys = {};

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentLyric(int index) {
    if (!_lyricKeys.containsKey(index)) return;

    final key = _lyricKeys[index];
    final context = key?.currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.4, // Position at 40% from top (slightly above center)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lyricsAsync = ref.watch(parsedLyricsProvider);
    final currentIndex = ref.watch(currentLyricIndexProvider);

    return lyricsAsync.when(
      data: (lyrics) {
        if (lyrics == null || lyrics.isEmpty) {
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

        // Ensure keys exist for all lyrics
        for (var i = 0; i < lyrics.length; i++) {
          _lyricKeys.putIfAbsent(i, GlobalKey.new);
        }

        // Auto-scroll to current lyric
        if (currentIndex >= 0 && currentIndex < lyrics.length) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToCurrentLyric(currentIndex);
          });
        }

        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
            itemCount: lyrics.length,
            itemBuilder: (context, index) {
              final isActive = index == currentIndex;
              final lyric = lyrics[index];

              return Padding(
                key: _lyricKeys[index],
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  style: TextStyle(fontFamily:"Uthmani",
                                      fontWeight: isActive ? FontWeight.w900 : FontWeight.w600,
                    fontSize: isActive ? 64 : 24,
                    color: isActive
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onPrimaryContainer.withOpacity(0.4),
                    height: 1.8,

                  ),
                  child: Text(lyric.words, textAlign: TextAlign.center),
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

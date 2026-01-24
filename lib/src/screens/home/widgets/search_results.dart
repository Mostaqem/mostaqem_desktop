import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_m3shapes/flutter_m3shapes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/theme/theme.dart';
import 'package:mostaqem/src/screens/home/data/search_history_item.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/home/providers/search_history_provider.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/reading/reading_screen.dart';
import 'package:mostaqem/src/screens/reciters/providers/reciters_repository.dart';
import 'package:mostaqem/src/screens/reciters/providers/search_notifier.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';
import 'package:motor/motor.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({super.key});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  String selected = 'الكل';
  final filters = ['الكل', 'السور', 'القراء'];

  String pluralVerses(int verses) {
    if (verses == 1) {
      return 'آية';
    }
    if (verses >= 2 && verses <= 10) {
      return 'آيات';
    }
    return 'آية';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          spacing: 8,
          children: filters
              .map(
                (e) => FilterChip(
                  selected: e == selected,
                  label: Text(e),
                  onSelected: (v) {
                    setState(() {
                      selected = e;
                    });
                  },
                ),
              )
              .toList(),
        ),

        const SizedBox(height: 16),

        Visibility(
          visible: selected != 'القراء',
          child: Consumer(
            builder: (context, ref, child) {
              final searchQuery = ref.watch(searchProvider('home'));
              final surahs = ref.watch(
                searchChaptersProvider(query: searchQuery),
              );
              final currentSurah = ref.watch(currentSurahProvider);
              return AsyncWidget(
                value: surahs,
                data: (data) {
                  if (data.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'السور',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            ' ( ${data.length.toString().toArabicNumbers} )',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        padding: .zero,

                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final currentPlaying =
                              currentSurah?.id == data[index].id;
                          return _FadeInListItem(
                            delay: Duration(milliseconds: index * 50),
                            child: ContextMenuRegion(
                              contextMenu: GenericContextMenu(
                                buttonConfigs: [
                                  ContextMenuButtonConfig(
                                    'تشغيل التالي',
                                    onPressed: () async {
                                      await ref
                                          .read(playerProvider.notifier)
                                          .addItemNext(data[index].id);
                                    },
                                  ),
                                  ContextMenuButtonConfig(
                                    'اضافة في القائمة التشغيل',
                                    onPressed: () async {
                                      await ref
                                          .read(playerProvider.notifier)
                                          .addToQueue(surahID: data[index].id);
                                    },
                                  ),
                                ],
                              ),
                              child: _HoverBounceItem(
                                builder: (isHovered) => InkWell(
                                  onTap: () {
                                    ref
                                        .read(searchHistoryProvider.notifier)
                                        .add(
                                          data[index].id,
                                          data[index].name,
                                          SearchType.surah,
                                        );
                                    ref
                                        .read(playerProvider.notifier)
                                        .play(surahID: data[index].id);
                                  },
                                  child: Ink(
                                    child: ClipRSuperellipse(
                                      borderRadius: .circular(16),
                                      child: Container(
                                        padding: const .all(16),
                                        decoration: BoxDecoration(
                                          color: currentPlaying
                                              ? Theme.of(
                                                  context,
                                                ).colorScheme.secondaryContainer
                                              : isHovered
                                              ? Theme.of(context)
                                                    .colorScheme
                                                    .surfaceContainerHighest
                                              : null,
                                        ),
                                        child: Row(
                                          children: [
                                            AnimatedSize(
                                              duration: const Duration(
                                                milliseconds: 300,
                                              ),
                                              curve: Curves.easeInOut,
                                              child: AnimatedSwitcher(
                                                duration: const Duration(
                                                  milliseconds: 250,
                                                ),
                                                transitionBuilder:
                                                    (child, animation) {
                                                      return FadeTransition(
                                                        opacity: animation,
                                                        child: child,
                                                      );
                                                    },
                                                child: currentPlaying
                                                    ? Row(
                                                        key: const ValueKey(
                                                          'playing',
                                                        ),
                                                        children: [
                                                          M3Container.sunny(
                                                            width: 35,
                                                            height: 35,
                                                            color:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .colorScheme
                                                                    .secondary,
                                                            child: Align(
                                                              child: Text(
                                                                data[index].id
                                                                    .toString()
                                                                    .toArabicNumbers,
                                                                textAlign:
                                                                    .center,
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                      .bold,
                                                                  fontFamily:
                                                                      AppTheme
                                                                          .secondFontFamily,
                                                                  color: Theme.of(
                                                                    context,
                                                                  ).colorScheme.onSecondary,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 16,
                                                          ),
                                                        ],
                                                      )
                                                    : const SizedBox.shrink(
                                                        key: ValueKey(
                                                          'not-playing',
                                                        ),
                                                      ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: .start,
                                              children: [
                                                Text(
                                                  data[index].name,
                                                  style: const TextStyle(
                                                    fontWeight: .w600,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                IntrinsicHeight(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        '',
                                                        style: TextStyle(
                                                          color: Theme.of(
                                                            context,
                                                          ).colorScheme.primary,
                                                          fontFamily: AppTheme
                                                              .secondFontFamily,
                                                        ),
                                                      ),
                                                      VerticalDivider(
                                                        color: Theme.of(
                                                          context,
                                                        ).colorScheme.primary,
                                                      ),
                                                      Text(
                                                        data[index].revelationPlace ==
                                                                1
                                                            ? 'مكية'
                                                            : 'مدنية',
                                                        style: TextStyle(
                                                          color: Theme.of(
                                                            context,
                                                          ).colorScheme.primary,
                                                          fontFamily: AppTheme
                                                              .secondFontFamily,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        Visibility(
          visible: selected != 'السور',
          child: Consumer(
            builder: (context, ref, child) {
              final searchQuery = ref.watch(searchProvider('home'));
              final reciters = ref.watch(
                searchReciterProvider(query: searchQuery),
              );
              final currentReciter = ref.watch(currentReciterProvider);
              return AsyncWidget(
                value: reciters,
                loading: SizedBox.shrink,
                data: (data) {
                  if (data.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'القراء',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            ' ( ${data.length.toString().toArabicNumbers} )',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ListView.separated(
                        itemCount: data.length,
                        shrinkWrap: true,
                        padding: .zero,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final currentPlaying =
                              data[index].id == currentReciter?.id;
                          return InkWell(
                            onTap: () {
                              ref
                                  .read(searchHistoryProvider.notifier)
                                  .add(
                                    data[index].id,
                                    data[index].name,
                                    SearchType.reciter,
                                  );
                              ref
                                  .read(userReciterProvider.notifier)
                                  .setReciter(data[index]);
                              final surah = ref.read(currentSurahProvider);
                              ref
                                  .read(playerProvider.notifier)
                                  .play(surahID: surah!.id);
                            },
                            child: _FadeInListItem(
                              delay: Duration(milliseconds: index * 50),
                              child: _HoverBounceItem(
                                builder: (isHovered) => ClipRSuperellipse(
                                  borderRadius: .circular(16),
                                  child: Container(
                                    padding: const .all(16),
                                    decoration: BoxDecoration(
                                      color: currentPlaying || isHovered
                                          ? Theme.of(context)
                                                .colorScheme
                                                .surfaceContainerHighest
                                          : null,
                                    ),
                                    child: Row(
                                      children: [
                                        M3Container.sunny(
                                          width: 35,
                                          height: 35,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                          child: const SizedBox.shrink(),
                                        ),
                                        const SizedBox(width: 16),
                                        Text(data[index].name),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FadeInListItem extends StatefulWidget {
  const _FadeInListItem({required this.child, this.delay = Duration.zero});
  final Widget child;
  final Duration delay;

  @override
  State<_FadeInListItem> createState() => _FadeInListItemState();
}

class _FadeInListItemState extends State<_FadeInListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: widget.child);
  }
}

class _HoverBounceItem extends StatefulWidget {
  const _HoverBounceItem({required this.builder});

  final Widget Function(bool isHovered) builder;

  @override
  State<_HoverBounceItem> createState() => _HoverBounceItemState();
}

class _HoverBounceItemState extends State<_HoverBounceItem> {
  double _targetScale = 1;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        _targetScale = 0.98;
        _isHovered = true;
      }),
      onExit: (_) => setState(() {
        _targetScale = 1.0;
        _isHovered = false;
      }),
      child: SingleMotionBuilder(
        motion: const CupertinoMotion.bouncy(),
        value: _targetScale,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: widget.builder(_isHovered),
          );
        },
      ),
    );
  }
}

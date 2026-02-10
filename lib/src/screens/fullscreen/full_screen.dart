import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:mostaqem/src/core/theme/theme.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';
import 'package:mostaqem/src/screens/fullscreen/providers/lyrics_notifier.dart';
import 'package:mostaqem/src/screens/fullscreen/widgets/scrollable_lyrics_view.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/broadcast/broadcast_fullscreen.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/shared/internet_checker/network_checker.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';

class FullScreenWidget extends ConsumerStatefulWidget {
  const FullScreenWidget({required this.player, super.key});
  final Album player;

  @override
  ConsumerState<FullScreenWidget> createState() => _FullScreenWidgetState();
}

class _FullScreenWidgetState extends ConsumerState<FullScreenWidget> {
  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connection = ref.watch(getConnectionProvider).value;
    final randomImage = ref.watch(fetchRandomImageProvider);
    final isLyricsVisible = ref.watch(lyricsProvider);
    final theme = Theme.of(context);
    final isbroadcast = ref.watch(isBroadcastProvider);
    final locale = ref.watch(localeProvider).languageCode;
    final showControls = ref.watch(showControlsProvider);

    return isbroadcast
        ? const BroadcastFullscreenWidget()
        : MouseRegion(
            onHover: (_) {
              ref.read(showControlsProvider.notifier).show();
            },
            child: Stack(
              children: [
                SoftEdgeBlur(
                  edges: showControls
                      ? [
                          EdgeBlur(
                            type: EdgeType.bottomEdge,
                            size: 200,
                            sigma: 25,
                            tintColor: Colors.black.withValues(alpha: 0.5),
                            controlPoints: [
                              ControlPoint(
                                position: 0.5,
                                type: ControlPointType.visible,
                              ),
                              ControlPoint(
                                position: 1,
                                type: ControlPointType.transparent,
                              ),
                            ],
                          ),
                        ]
                      : [],
                  child: AsyncWidget(
                    value: randomImage,
                    data: (data) {
                      return SizedBox.expand(
                        child: Image.network(
                          data,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),

                Visibility(
                  visible: isLyricsVisible,
                  child: SoftEdgeBlur(
                    edges: [
                      EdgeBlur(
                        type: EdgeType.bottomEdge,
                        size: 600,
                        sigma: 55,

                        controlPoints: [
                          ControlPoint(
                            position: 0.5,
                            type: ControlPointType.visible,
                          ),
                          ControlPoint(
                            position: 1,
                            type: ControlPointType.transparent,
                          ),
                        ],
                      ),
                      EdgeBlur(
                        type: EdgeType.topEdge,
                        size: 300,
                        sigma: 55,

                        controlPoints: [
                          ControlPoint(
                            position: 0.5,
                            type: ControlPointType.visible,
                          ),
                          ControlPoint(
                            position: 1,
                            type: ControlPointType.transparent,
                          ),
                        ],
                      ),
                    ],
                    child: AnimatedMeshGradient(
                      options: AnimatedMeshGradientOptions(),
                      colors: [
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.secondaryContainer,
                        Theme.of(context).colorScheme.tertiaryContainer,
                        Theme.of(context).colorScheme.primary,
                      ],
                      child: const ScrollableLyricsView(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 120,
                    right: 35,
                    left: 35,
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: .end,
                      children: [
                        Text(
                          widget.player.surah.name,
                          style: TextStyle(
                            fontSize: 120,
                            fontFamily: AppTheme.thirdFontFamily,
                            fontWeight: FontWeight.w700,
                            color: isLyricsVisible
                                ? Theme.of(context).colorScheme.onSurface
                                : Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          widget.player.reciter.name,
                          style: TextStyle(
                            fontSize: 18,
                            color: isLyricsVisible
                                ? Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withValues(alpha: 0.5)
                                : Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                        Visibility(
                          visible: ref.watch(isLocalProvider),
                          child: Text(
                            context.tr.offline_playback,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.tertiary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: showControls ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Align(
                      alignment: locale == 'ar'
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: CircleAvatar(
                        backgroundColor: theme.colorScheme.surface,
                        child: ToolTipIconButton(
                          message: context.tr.change_image,
                          onPressed: () {
                            ref.invalidate(fetchRandomImageProvider);
                          },
                          icon: const Icon(Icons.arrow_forward_outlined),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mostaqem/src/core/dio/dio_helper.dart';
import 'package:mostaqem/src/screens/fullscreen/providers/lyrics_notifier.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/repository/lyrics_repository.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/broadcast/broadcast_fullscreen.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/shared/internet_checker/network_checker.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';

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
    final isLyricsVisible = ref.watch(lyricsNotifierProvider);
    final lyrics = ref.watch(currentLyricsNotifierProvider);
    final theme = Theme.of(context);
    final isbroadcast = ref.watch(isBroadcastProvider);
    return isbroadcast
        ? const BroadcastFullscreenWidget()
        : Stack(
            children: [
              if (connection == InternetConnectionStatus.connected &&
                  isProduction)
                AsyncWidget(
                  value: randomImage,
                  data: (data) {
                    return SizedBox.expand(
                      child: Image.network(
                        data,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child; // Image loaded
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
                )
              else
                SizedBox.expand(
                  child: Image.asset('assets/img/kaaba.jpg', fit: BoxFit.cover),
                ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 0.5, 0.3, 1],
                  ),
                ),
              ),
              Visibility(
                visible: isLyricsVisible,
                child: Center(
                  child: Container(
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.8),
                    ),
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(
                        context,
                      ).copyWith(scrollbars: false),
                      child: AsyncWidget(
                        value: lyrics,
                        data: (data) {
                          if (data == null) {
                            return const Text(
                              'عفوا, لا يوجد كلمات , سوف نضيفها مع الوقت',
                              style: TextStyle(color: Colors.white),
                            );
                          }
                          return Text(
                            data,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.amiri(
                              fontWeight: FontWeight.w900,
                              fontSize: 24,
                              color: theme.colorScheme.primary,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 220, right: 50),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width / 10,
                        height: MediaQuery.sizeOf(context).width / 10,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              widget.player.surah.image ??
                                  'https://img.freepik.com/premium-photo/illustration-mosque-with-crescent-moon-stars-simple-shapes-minimalist-flat-design_217051-15556.jpg',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.player.surah.arabicName,
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            widget.player.reciter.arabicName,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                          Visibility(
                            visible: ref.watch(isLocalProvider),
                            child: Text(
                              'تشغيل اوفلاين',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.tertiary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    backgroundColor: theme.colorScheme.surface,
                    child: ToolTipIconButton(
                      message: 'تغير الصورة',
                      onPressed: () {
                        ref.invalidate(fetchRandomImageProvider);
                      },
                      icon: const Icon(Icons.arrow_forward_outlined),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}

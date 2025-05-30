import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mostaqem/src/core/dio/dio_helper.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/shared/internet_checker/network_checker.dart'
    show getConnectionProvider;
import 'package:mostaqem/src/shared/widgets/async_widget.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';

class BroadcastFullscreenWidget extends ConsumerStatefulWidget {
  const BroadcastFullscreenWidget({super.key});

  @override
  ConsumerState<BroadcastFullscreenWidget> createState() =>
      _BroadcastFullscreenWidgetState();
}

class _BroadcastFullscreenWidgetState
    extends ConsumerState<BroadcastFullscreenWidget> {
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
    final theme = Theme.of(context);
    final broadcast = ref.watch(currentBroadcastProvider);
    return Stack(
      children: [
        if (connection == InternetConnectionStatus.connected && isProduction)
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

        Padding(
          padding: const EdgeInsets.only(bottom: 220, right: 50),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              broadcast.toString(),
              style: const TextStyle(fontSize: 30, color: Colors.white),
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

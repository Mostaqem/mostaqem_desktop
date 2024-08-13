import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mostaqem/src/core/screens/screens.dart';
import 'package:mostaqem/src/screens/navigation/repository/fullscreen_notifier.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/player_widget.dart';
import 'package:mostaqem/src/shared/device/package_repository.dart';
import 'package:mostaqem/src/shared/widgets/app_menu_bar.dart';
import 'package:mostaqem/src/shared/widgets/full_screen.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';
import 'package:mostaqem/src/shared/widgets/window_buttons.dart';

final isExtendedProvider = StateProvider<bool>((ref) => false);

class Navigation extends ConsumerStatefulWidget {
  const Navigation({super.key});

  @override
  ConsumerState<Navigation> createState() => _NavigationState();
}

class _NavigationState extends ConsumerState<Navigation> {
  final repo = PackageRepository();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final state = await repo.checkUpdate();
      if (!mounted) return;
      if (state == UpdateState.available) {
        await checkUpdateDialog(context, ref);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isFullScreen = ref.watch(isFullScreenProvider);
    final player = ref.watch(playerSurahProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isFullScreen
          ? FullScreenWidget(player: player!, ref: ref)
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    const WindowButtons(),
                    Expanded(
                      child: Consumer(
                        builder: (context, ref, child) {
                          final children = ref.watch(childrenProvider);
                          final screenIndex = ref.watch(indexScreenProvider);
                          return Row(
                            children: [
                              RightSide(
                                children: children,
                                screenIndex: screenIndex,
                              ),
                              LeftSide(
                                children: children,
                                screenIndex: screenIndex,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class RightSide extends ConsumerWidget {
  const RightSide({
    required this.children,
    required this.screenIndex,
    super.key,
  });
  final List<Screen> children;
  final int screenIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: SizedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: NavigationRail(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            extended: ref.watch(isExtendedProvider),
            trailing: Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ToolTipIconButton(
                    message: 'اعدادات',
                    onPressed: () => context.go('/settings'),
                    icon: const Icon(Icons.settings_outlined),
                  ),
                ),
              ),
            ),
            leading: ToolTipIconButton(
              message: ref.watch(isExtendedProvider) ? 'تصغير' : 'توسيع',
              icon: const Icon(Icons.menu),
              onPressed: () => ref
                  .read(isExtendedProvider.notifier)
                  .update((state) => !state),
            ),
            indicatorShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            destinations: [
              ...children.map(
                (child) => NavigationRailDestination(
                  icon: child.icon,
                  label: Text(child.label),
                  selectedIcon: child.selectedIcon,
                ),
              ),
            ],
            selectedIndex: screenIndex,
            onDestinationSelected: (value) =>
                ref.read(indexScreenProvider.notifier).state = value,
          ),
        ),
      ),
    );
  }
}

class LeftSide extends StatelessWidget {
  const LeftSide({
    required this.children,
    required this.screenIndex,
    super.key,
  });

  final List<Screen> children;
  final int screenIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: children[screenIndex].widget,
      ),
    );
  }
}

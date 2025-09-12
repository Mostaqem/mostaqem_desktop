import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mostaqem/src/core/dio/dio_helper.dart';
import 'package:mostaqem/src/core/env/env.dart';
import 'package:mostaqem/src/core/screens/screens.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';
import 'package:mostaqem/src/screens/fullscreen/full_screen.dart';
import 'package:mostaqem/src/screens/navigation/repository/fullscreen_notifier.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/occasions/domain/occasions_repository.dart';
import 'package:mostaqem/src/screens/occasions/occasions.dart';
import 'package:mostaqem/src/shared/device/package_repository.dart';
import 'package:mostaqem/src/shared/widgets/app_menu_bar.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';
import 'package:mostaqem/src/shared/widgets/window_buttons.dart';

final isExtendedProvider = StateProvider<bool>((ref) => false);

class Navigation extends ConsumerStatefulWidget {
  const Navigation({super.key});

  @override
  ConsumerState<Navigation> createState() => _NavigationState();
}

class _NavigationState extends ConsumerState<Navigation> {
  @override
  void initState() {
    super.initState();
    if (Constants.mStore == false && isProduction) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final state = await ref.read(checkUpdateProvider.future);
        if (!mounted) return;
        if (state == UpdateState.available) {
          await checkUpdateDialog(context, ref);
        }
      });
    }
  }

  Screen getSpecialPage(BuildContext context) => Screen(
    icon: const Icon(Icons.star_outline_rounded),
    selectedIcon: const Icon(Icons.star_rounded),
    label: context.tr.occasions,
    widget: const OccasionsScreen(),
  );

  @override
  Widget build(BuildContext context) {
    final isFullScreen = ref.watch(isFullScreenProvider);
    final player = ref.watch(
      playerNotifierProvider.select((value) => value.album),
    );
    var children = getChildrenScreens(context);
    final screenIndex = ref.watch(indexScreenProvider);
    final isTodaySpecial = ref.watch(occasionsRepoProvider).isTodaySpecial();
    if (isTodaySpecial) {
      children = {...children, getSpecialPage(context)};
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isFullScreen
          ? FullScreenWidget(player: player!)
          : Column(
              children: [
                const WindowButtons(),
                Expanded(
                  child: Row(
                    children: [
                      RightSide(children: children, screenIndex: screenIndex),
                      LeftSide(children: children, screenIndex: screenIndex),
                    ],
                  ),
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
  final Set<Screen> children;
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
                    message: context.tr.settings,
                    onPressed: () => context.go('/settings'),
                    icon: const Icon(Icons.settings_outlined),
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => ref
                  .read(isExtendedProvider.notifier)
                  .update((state) => !state),
            ),
            indicatorShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
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

  final Set<Screen> children;
  final int screenIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: children.elementAt(screenIndex).widget,
      ),
    );
  }
}

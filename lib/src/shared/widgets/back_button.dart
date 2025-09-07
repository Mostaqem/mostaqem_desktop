import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mostaqem/src/core/routes/routes.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 10,
        children: [
          Consumer(
            builder: (context, ref, child) {
              return Visibility(
                visible: ref.watch(navigationProvider).isNavigationStackDeep(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Tooltip(
                    message: context.tr.back,
                    preferBelow: false,
                    child: IconButton(
                      icon: const Icon(Icons.home_outlined),
                      onPressed: () {
                        context.go('/');
                      },
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              );
            },
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Tooltip(
              message: context.tr.back,
              preferBelow: false,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  if (context.mounted) {
                    if (context.canPop()) {
                      context.pop();
                      return;
                    }
                    context.go('/');
                  }
                },
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

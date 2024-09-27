import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mostaqem/src/shared/widgets/hover_builder.dart';

import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';

class TextHover extends ConsumerWidget {
  const TextHover({
    required this.text,
    super.key,
    this.onTap,
  });

  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLocal = ref.watch(isLocalProvider);
    return HoverBuilder(
      builder: (isHovered) {
        return MouseRegion(
          cursor: isHovered && !isLocal
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          child: GestureDetector(
            onTap: onTap,
            child: Text(
              text,
              style: TextStyle(
                decoration: isHovered && !isLocal
                    ? TextDecoration.underline
                    : TextDecoration.none,
                color: isHovered && !isLocal
                    ? Theme.of(context).colorScheme.onSecondaryContainer
                    : Theme.of(context)
                        .colorScheme
                        .onSecondaryContainer
                        .withOpacity(0.5),
              ),
            ),
          ),
        );
      },
    );
  }
}

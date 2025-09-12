import 'package:flutter/material.dart';

import 'package:mostaqem/src/shared/widgets/shortcuts/shortcuts_enum.dart';

class ShortcutLabel extends StatelessWidget {
  const ShortcutLabel({required this.shortcut, super.key});
  final ShortcutsEnum shortcut;

  @override
  Widget build(BuildContext context) {
    if (shortcut.hidden) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: shortcut.control,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                    child: const Text('Ctrl'),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
                child: Text(
                  shortcut.key.keyLabel == ' '
                      ? 'space'
                      : shortcut.key.keyLabel,
                ),
              ),
            ],
          ),
          Text(shortcut.getName(context)),
        ],
      ),
    );
  }
}

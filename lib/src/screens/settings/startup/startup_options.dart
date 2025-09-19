import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';
import 'package:mostaqem/src/screens/settings/startup/provider/startup_provider.dart';
import 'package:mostaqem/src/screens/settings/startup/startup_state.dart';

class StartupOptions extends StatelessWidget {
  const StartupOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.startup_behavior,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(context.tr.startup_play),
          trailing: Consumer(
            builder: (context, ref, child) {
              final initValue =
                  ref.watch(startupNotifierProvider).value ?? 'ابدا';
              return DropdownMenu(
                initialSelection: initValue,
                onSelected: (value) => ref
                    .read(startupNotifierProvider.notifier)
                    .toggle(value: value!),
                dropdownMenuEntries: StartupState.values
                    .map(
                      (e) => DropdownMenuEntry(
                        value: e.text,
                        label: getStartupValue(context, e.text),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/settings/startup/provider/startup_provider.dart';
import 'package:mostaqem/src/screens/settings/startup/startup_state.dart';

class StartupOptions extends StatelessWidget {
  const StartupOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'سلوك بدء التشغيل',
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        ListTile(
          title: const Text(
            'تشغيل مستقيم تلقائيا بعد تسجيل الدخول إلى جهاز الكمبيوتر',
          ),
          trailing: Consumer(
            builder: (context, ref, child) {
              final startup =
                  ref.watch(startupNotifierProvider).value ?? 'ابدا';

              return DropdownMenu(
                initialSelection: startup,
                onSelected: (value) => ref
                    .read(startupNotifierProvider.notifier)
                    .toggle(value: value!),
                dropdownMenuEntries: StartupState.values
                    .map((e) => DropdownMenuEntry(value: e.text, label: e.text))
                    .toList(),
              );
            },
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        ListTile(
          title: const Text('زر الإغلاق يصغر شاشة مستقيم'),
          trailing: Consumer(
            builder: (context, ref, child) {
              final isMinimize = ref.watch(minimizeNotifierProvider);
              return Switch(
                value: isMinimize,
                onChanged: (value) => ref
                    .read(minimizeNotifierProvider.notifier)
                    .toggle(value: value),
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/settings/providers/download_cache.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';
import 'package:mostaqem/src/shared/widgets/back_button.dart';
import 'package:mostaqem/src/shared/widgets/window_buttons.dart';

class SettingsScreen extends ConsumerWidget {
  SettingsScreen({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = ref.watch(downloadDestinationProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WindowButtons(),
        const SizedBox(
          height: 10,
        ),
        const Align(alignment: Alignment.topLeft, child: AppBackButton()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'الاعدادات',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 52,
                ),
                Text(
                  'التحميلات',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'اختار مكان تنزيل القران',
                ),
                const SizedBox(
                  height: 4,
                ),
                AsyncWidget(
                  value: path,
                  loading: const SizedBox.shrink(),
                  data: (data) {
                    return ConstrainedBox(
                      constraints:
                          const BoxConstraints(minWidth: 200, maxWidth: 500),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: data,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'يجب ادخال مكان لتنزيل التحميلات';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    elevation: const WidgetStatePropertyAll<double>(0),
                  ),
                  onPressed: () async {
                    final selectedDirectory =
                        await FilePicker.platform.getDirectoryPath();
                    if (!context.mounted) return;
                    if (selectedDirectory != null) {
                      await ref
                          .read(downloadCacheProvider.notifier)
                          .changePath(path: selectedDirectory);
                    }
                  },
                  child: const Text('اختيار مكان'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

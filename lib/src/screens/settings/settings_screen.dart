import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';

import 'providers/download_cache.dart';

class SettingsScreen extends ConsumerWidget {
  SettingsScreen({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = ref.watch(downloadDestinationProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "الاعدادات",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 52,
        ),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "التحميلات",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "اختار مكان تنزيل التحميلات",
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
                              return "يجب ادخال مكان لتنزيل التحميلات";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder())),
                    );
                  }),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  String? selectedDirectory =
                      await FilePicker.platform.getDirectoryPath();
                  if (!context.mounted) return;
                  if (selectedDirectory != null) {
                    ref
                        .read(downloadCacheProvider.notifier)
                        .changePath(path: selectedDirectory);
                  }
                },
                child: const Text("اختيار مكان"),
              )
            ],
          ),
        ),
      ],
    );
  }
}

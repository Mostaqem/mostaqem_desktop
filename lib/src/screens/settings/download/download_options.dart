import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/settings/providers/download_cache.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';

class DownloadOptions extends StatelessWidget {
  const DownloadOptions({super.key});

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'التحميلات',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 8),
          const Text('اختار مكان تنزيل القران'),
          const SizedBox(height: 4),
          Consumer(
            builder: (context, ref, child) {
              final path = ref.watch(downloadDestinationProvider);

              return AsyncWidget(
                value: path,
                loading: () => const SizedBox.shrink(),
                data: (data) {
                  return ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 200,
                      maxWidth: 500,
                    ),
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
              );
            },
          ),
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
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
              );
            },
          ),
        ],
      ),
    );
  }
}

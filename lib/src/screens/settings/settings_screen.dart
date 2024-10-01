import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/settings/appearance/apperance.dart';
import 'package:mostaqem/src/screens/settings/download/download_options.dart';
import 'package:mostaqem/src/shared/cache/cache_helper.dart';
import 'package:mostaqem/src/shared/widgets/back_button.dart';
import 'package:mostaqem/src/shared/widgets/snackbar.dart';
import 'package:mostaqem/src/shared/widgets/window_buttons.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WindowButtons(),
            const SizedBox(
              height: 10,
            ),
            const Align(alignment: Alignment.topLeft, child: AppBackButton()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  const DownloadOptions(),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'مظهر',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const ApperanceSettings(),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'ملفات المؤقتة',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      CacheHelper.clear();
                      DefaultCacheManager().emptyCache();
                      appSnackBar(context, message: 'تم حدف الملفات بنجاح');
                    },
                    child: const Text('حذف الملفات'),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}

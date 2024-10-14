import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/settings/widgets/app_setting_widget.dart';
import 'package:mostaqem/src/screens/settings/widgets/web_setting_widget.dart';
import 'package:universal_platform/universal_platform.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return (UniversalPlatform.isWeb)
        ? const SettingsWebWidget()
        : const SettingsWidget();
  }
}
 
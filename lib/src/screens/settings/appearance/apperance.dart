import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mostaqem/src/screens/settings/appearance/providers/apperance_providers.dart';
import 'package:mostaqem/src/screens/settings/appearance/providers/squiggly_notifier.dart';
import 'package:mostaqem/src/screens/settings/appearance/providers/theme_notifier.dart';

class ApperanceSettings extends ConsumerStatefulWidget {
  const ApperanceSettings({
    super.key,
  });

  @override
  ConsumerState<ApperanceSettings> createState() => _ApperanceSettingsState();
}

class _ApperanceSettingsState extends ConsumerState<ApperanceSettings> {
  final List<Color> availableColors = [
    const Color.fromARGB(255, 224, 151, 237),
    const Color.fromARGB(255, 252, 135, 126),
    const Color.fromARGB(255, 137, 245, 141),
    const Color.fromARGB(255, 136, 225, 255),
    const Color.fromRGBO(255, 245, 151, 1),
  ];
  Color currentColor = const Color.fromRGBO(255, 245, 151, 1);
  Color pickerColor = const Color(0xff443a49);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: [
            InkWell(
              onTap: () {
                ref
                    .read(themeNotifierProvider.notifier)
                    .setTheme(ThemeMode.system);
              },
              child: Container(
                height: 80,
                alignment: Alignment.center,
                width: 120,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 132, 132, 132),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'النظام',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            InkWell(
              onTap: () {
                ref
                    .read(themeNotifierProvider.notifier)
                    .setTheme(ThemeMode.light);
              },
              child: Container(
                height: 80,
                alignment: Alignment.center,
                width: 120,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 176, 147),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.sunny,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            InkWell(
              onTap: () {
                ref
                    .read(themeNotifierProvider.notifier)
                    .setTheme(ThemeMode.dark);
              },
              child: Container(
                height: 80,
                alignment: Alignment.center,
                width: 120,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 30, 29, 29),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.dark_mode_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          'تغيير اللون',
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Wrap(
          children: [
            Wrap(
              spacing: 12,
              children: availableColors
                  .map(
                    (e) => ApperanceColor(
                      color: e,
                      isSelected: ref.watch(userSeedColorProvider) == e,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              width: 12,
            ),
            InkWell(
              onTap: () {
                showDialog<AlertDialog>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'اختيار اللون',
                        textDirection: TextDirection.rtl,
                      ),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: pickerColor,
                          onColorChanged: (color) {
                            setState(() {
                              pickerColor = color;
                            });
                          },
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('تغير المظهر'),
                          onPressed: () {
                            ref
                                .read(userSeedColorProvider.notifier)
                                .setColor(pickerColor);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                height: 80,
                alignment: Alignment.center,
                width: 120,
                decoration: BoxDecoration(
                  color: pickerColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.colorize),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            InkWell(
              onTap: () {
                ref.read(userSeedColorProvider.notifier).clear();
              },
              child: Container(
                height: 80,
                alignment: Alignment.center,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'اعادة اللون',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        CheckboxListTile(
          value: ref.watch(squigglyNotifierProvider),
          onChanged: (value) {
            ref
                .read(squigglyNotifierProvider.notifier)
                .toggle(value: value ?? false);
          },
          title: const Text('تغير الشكل الي موجات'),
        ),
      ],
    );
  }
}

class ApperanceColor extends ConsumerWidget {
  const ApperanceColor({
    required this.color,
    required this.isSelected,
    super.key,
  });
  final Color color;
  final bool isSelected;
  Color changeColorLightness(Color color, double lightness) =>
      HSLColor.fromColor(color).withLightness(lightness).toColor();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          ref.read(userSeedColorProvider.notifier).setColor(color);
        },
        child: Container(
          height: 80,
          width: 120,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: isSelected
              ? Icon(
                  Icons.radio_button_checked,
                  color: changeColorLightness(color, 0.2),
                )
              : null,
        ),
      ),
    );
  }
}

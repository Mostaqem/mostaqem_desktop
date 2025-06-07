import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';

class HijriDateWidget extends ConsumerStatefulWidget {
  const HijriDateWidget({super.key});

  @override
  ConsumerState<HijriDateWidget> createState() => _HijriDateWidgetState();
}

class _HijriDateWidgetState extends ConsumerState<HijriDateWidget> {
  @override
  void initState() {
    super.initState();
    final language = ref.read(localeNotifierProvider).languageCode;
    HijriCalendar.setLocal(language);
  }

  @override
  Widget build(BuildContext context) {
    final today = HijriCalendar.now();

    return Row(
      children: [
        Text(
          today.hDay.toString(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Text(
          today.getLongMonthName(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Text(
          today.hYear.toString(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

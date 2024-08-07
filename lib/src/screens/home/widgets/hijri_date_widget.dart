import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class HijriDateWidget extends StatelessWidget {
  const HijriDateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final today = HijriCalendar.now();

    return Row(
      children: [
        Text(
          today.hDay.toString(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          today.getLongMonthName(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          today.hYear.toString(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

enum Language implements Comparable<Language> {
  arabic(name: 'العربية', code: 'ar'),
  english(name: 'English', code: 'en', fontFamily: 'no');

  const Language({
    required this.name,
    required this.code,
    this.fontFamily = 'kufam',
  });

  final String name;
  final String code;
  final String fontFamily;

  @override
  int compareTo(Language other) => code.length - other.code.length;

  Locale toLocale() => Locale(code);
}

extension Locales on List<Language> {
  List<Locale> toLocales() {
    return map((e) => Locale(e.code)).toList();
  }

  List<DropdownMenuItem<String>> toItems() {
    return map(
      (e) => DropdownMenuItem(value: e.code, child: Text(e.name)),
    ).toList();
  }
}

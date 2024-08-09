import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _primaryColor = Color.fromARGB(255, 250, 210, 159);

  static final String? _fontFamily = GoogleFonts.kufam().fontFamily;

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: _primaryColor),
    fontFamily: _fontFamily,
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
      fontFamily: _fontFamily,
      colorScheme: ColorScheme.fromSeed(
          seedColor: _primaryColor, brightness: Brightness.dark,),);
}

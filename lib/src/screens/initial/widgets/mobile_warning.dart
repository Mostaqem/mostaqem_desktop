import 'dart:ui';
import 'package:flutter/material.dart';

class MobileWarningOverlay extends StatelessWidget {
  const MobileWarningOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black.withOpacity(0.3), // Semi-transparent background
      child: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'يبدو أنك تستخدم الهاتف المحمول، يفضل استخدام التطبيق على الحاسوب لتجربة أفضل',
              style: TextStyle(fontSize: 18, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:mostaqem/src/screens/home/home_screen.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Intro(child: HomeScreen());
  }
}

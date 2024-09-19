import 'package:flutter/material.dart';

import 'package:mostaqem/src/core/theme/theme.dart';

class InitialLoading extends StatelessWidget {
  const InitialLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/app_icon.png',
                width: 140,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'وَكَانَ فَضْلُ اللَّهِ عَلَيْكَ عَظِيمًا',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const Text('النساء : 113'),
              const SizedBox(
                height: 100,
              ),
              const CircularProgressIndicator(),
              const Spacer(),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'مستقيم 1.7.0',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

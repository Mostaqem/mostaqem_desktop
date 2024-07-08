import 'package:flutter/material.dart';

class AppLicensePage extends StatelessWidget {
  const AppLicensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const WindowBarBox(),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Theme(
            data: ThemeData(),
            child: const LicensePage(
              applicationVersion: "1.0.0",
              applicationName: "مستقيم",
            ),
          ))
        ],
      ),
    );
  }
}

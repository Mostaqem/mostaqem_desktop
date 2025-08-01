import 'package:flutter/material.dart';

class AppLicensePage extends StatelessWidget {
  const AppLicensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const WindowBarBox(),
          SizedBox(height: 10),
          Expanded(
            child: LicensePage(
              applicationVersion: '2.3.1',
              applicationName: 'مستقيم',
            ),
          ),
        ],
      ),
    );
  }
}

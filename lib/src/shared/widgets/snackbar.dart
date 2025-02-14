import 'package:flutter/material.dart';

void appSnackBar(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text(message)),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100,
        right: 320,
        left: 320,
      ),
    ),
  );
}

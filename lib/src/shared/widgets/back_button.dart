import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(18)),
        child: Tooltip(
          message: "رجوع",
          preferBelow: false,
          child: IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              if (context.mounted) {
                context.pop();
              }
            },
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}

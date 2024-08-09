import 'package:flutter/material.dart';

class ToolTipIconButton extends StatelessWidget {
  const ToolTipIconButton({
    required this.message,
    required this.onPressed,
    required this.icon,
    super.key,
    this.iconSize,
  });
  final String message;
  final void Function() onPressed;
  final Widget icon;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      preferBelow: false,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        iconSize: iconSize,
      ),
    );
  }
}

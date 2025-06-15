import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool filled;
  final Color? color;
  final double? width;
  final double? height;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.filled = true,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final buttonChild = icon == null
        ? Text(label)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: 8),
              Text(label),
            ],
          );
    final ButtonStyle style = filled
        ? ElevatedButton.styleFrom(
            backgroundColor: color,
            minimumSize: width != null && height != null ? Size(width!, height!) : null,
          )
        : OutlinedButton.styleFrom(
            foregroundColor: color,
            minimumSize: width != null && height != null ? Size(width!, height!) : null,
          );
    return filled
        ? ElevatedButton(
            onPressed: onPressed,
            style: style,
            child: buttonChild,
          )
        : OutlinedButton(
            onPressed: onPressed,
            style: style,
            child: buttonChild,
          );
  }
}

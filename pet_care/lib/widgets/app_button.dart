import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool filled;
  final Color? color;
  final double? width;
  final double? height;
  final bool isCircle;
  final String? imageAsset;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.filled = true,
    this.color,
    this.width,
    this.height,
    this.isCircle = true,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    final buttonChild = imageAsset != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(imageAsset!, width: 32, height: 32),
              if (label.isNotEmpty) ...[
                const SizedBox(width: 8),
                Text(label),
              ],
            ],
          )
        : icon == null
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isCircle ? 30 : 10),
            ),
          )
        : OutlinedButton.styleFrom(
            foregroundColor: color,
            minimumSize: width != null && height != null ? Size(width!, height!) : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isCircle ? 30 : 10),
            ),
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

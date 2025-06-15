import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;

  const HomeButton({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      tooltip: 'Home',
      onPressed: onPressed,
    );
  }
}
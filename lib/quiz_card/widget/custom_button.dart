import 'package:flutter/material.dart';

class ReuseButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color color;
  final double size;

  const ReuseButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.color = Colors.blueAccent,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: color, size: size),
      onPressed: onPressed,
      tooltip: 'Press this button',
    );
  }
}

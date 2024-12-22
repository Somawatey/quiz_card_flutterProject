import 'package:flutter/material.dart';

class ReuseButton extends StatelessWidget {
  final VoidCallback? onPress;
  final VoidCallback? onTap;
  final IconData? icon;
  final String label;
  final Color color;
 

  const ReuseButton({
    super.key,
    this.onPress,
    this.onTap,
    this.icon,
    required this.label,
    this.color = Colors.purple,
   
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ElevatedButton.icon(
        onPressed: onPress, 
        icon: Icon(icon, color: Colors.black54,size: 20,), // The icon
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black, // Set the label color here
          ),
        ), // The text
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // Button background color
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
      ),
    );
  }
}
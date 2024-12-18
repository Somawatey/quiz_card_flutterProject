import 'package:flutter/material.dart';

class ReuseCard extends StatelessWidget {
  final String title;
  final String description;
  final Color borderColor;
  final Widget? actionWidget; // This is the widget for action like delete, edit, etc.

  const ReuseCard({
    super.key,
    required this.title,
    required this.description,
    required this.borderColor,
    this.actionWidget, // Default action is null
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Colored border on the side
          Container(
            width: 8,
            height: 80,
            decoration: BoxDecoration(
              color: borderColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
          // Main content of the card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Action widget like a delete button
          if (actionWidget != null) actionWidget!,
        ],
      ),
    );
  }
}

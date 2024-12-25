import 'package:flutter/material.dart';

class ReuseCard extends StatelessWidget {
  final String title;
  final String? description;
  final Color borderColor;
  final Widget? actionWidget; // This is the widget for action like delete, edit, etc.

  const ReuseCard({
    super.key,
    required this.title,
    this.description,
    this.borderColor = Colors.purple,
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
          Expanded(
            child: ListTile(
              title: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: description != null ? Text(description!) : null,
              trailing: actionWidget,
            ),
          ),
        ],
      ),
    );
  }
}
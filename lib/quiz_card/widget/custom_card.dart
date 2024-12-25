import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReuseCard extends StatelessWidget {
  final String title;
  final String? description;
  final Color borderColor;
  final Widget? actionWidget;
  final DateTime? date;

  const ReuseCard({
    super.key,
    required this.title,
    this.description,
    this.borderColor = Colors.purple,
    this.actionWidget,
    this.date,
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
                  fontSize: 16,
                ),
              ),
              subtitle: description != null ? Text(description!) : null,
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (date != null)
                    Text(
                      DateFormat('dd/MM/yyyy').format(date!),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  if (actionWidget != null) actionWidget!,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

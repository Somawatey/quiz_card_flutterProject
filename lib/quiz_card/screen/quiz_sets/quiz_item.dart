import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quiz_card_project/quiz_card/class_model/quiz_set.dart';

class QuizItem extends StatelessWidget {
  final QuizSet quizSet;
  final formatter = DateFormat.yMd();

  QuizItem(this.quizSet, {super.key});

  String get formattedDate => formatter.format(quizSet.date);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            
            // Left side: Title and Description
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quizSet.title, // Use the title property here
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  quizSet.description ?? "", // Use the description property here
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              formattedDate, // Use the formatted date
              style: const TextStyle(color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}

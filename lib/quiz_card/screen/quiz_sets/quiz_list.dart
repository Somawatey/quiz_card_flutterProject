import 'package:flutter/material.dart';
import 'package:quiz_card_project/quiz_card/class_model/quiz_set.dart';
//import 'package:quiz_card_project/quiz_card/widget/custom_button.dart';
import 'package:quiz_card_project/quiz_card/widget/custom_card.dart';

class QuizList extends StatelessWidget {
  final List<QuizSet> quizSets;
  final Function(QuizSet) onQuizRemoved;

  const QuizList({
    super.key,
    required this.quizSets,
    required this.onQuizRemoved,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: quizSets.length,
      itemBuilder: (context, index) {
        final quizSet = quizSets[index];

        // Wrap the card in Dismissible for swipe-to-delete functionality
        return Dismissible(
          key: Key(quizSet.title), // Unique key based on quiz title
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            onQuizRemoved(quizSet); // Call the callback to remove the quiz
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${quizSet.title} removed'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          background: Container(
            color: Colors.redAccent,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white, size: 30),
          ),

          // Reusable Card with dynamic border and delete button
          child: ReuseCard(
            title: quizSet.title,
            description: quizSet.description,
            //color base on index that we provide
            borderColor: _getBorderColor(index),
            //icon delete on the left side
            // trailingWidget: ReuseButton(
            //   icon: Icons.delete,
            //   color: Colors.redAccent,
            //   size: 28.0,
            //   onPressed: () => onQuizRemoved(quizSet),
            // ),
          ),
        );
      },
    );
  }

  // Generate dynamic border colors
  Color _getBorderColor(int index) {
    const colors = [
      Colors.purpleAccent,
      Colors.blueAccent,
      Colors.pinkAccent,
      Colors.deepPurpleAccent,
      Colors.lightBlueAccent,
    ];
    return colors[index % colors.length];
  }
}

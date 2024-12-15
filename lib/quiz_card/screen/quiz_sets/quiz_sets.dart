import 'package:flutter/material.dart';
import 'package:quiz_card_project/quiz_card/class_model/quiz_set.dart';
import 'package:quiz_card_project/quiz_card/screen/quiz_sets/quiz_form.dart';
import 'package:quiz_card_project/quiz_card/widget/custom_card.dart'; // Import your custom card widget (if any)
//import 'package:quiz_card_project/quiz_card/screen/questions/add_question.dart'; // Import the screen for adding questions

class QuizSets extends StatefulWidget {
  const QuizSets({super.key});

  @override
  State<QuizSets> createState() => _QuizSetsState();
}

class _QuizSetsState extends State<QuizSets> {
  final List<QuizSet> _registeredQuizzes = [
    QuizSet(
      title: 'Flutter Basics',
      description: 'Learn the basics of Flutter framework.',
      date: DateTime.now(),
    ),
    QuizSet(
      title: 'Dart Syntax',
      description: 'A quick test on Dart syntax.',
      date: DateTime.now(),
    ),
  ];

  void _removeQuiz(QuizSet quizSet) {
    setState(() {
      _registeredQuizzes.remove(quizSet);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Quiz removed.'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredQuizzes.add(quizSet);
            });
          },
        ),
      ),
    );
  }

  void _showQuizOptions(QuizSet quizSet) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Add question in ${quizSet.title}'),
                onTap: () {
                  // Add your logic to add a question
                  Navigator.of(ctx).pop();
                },
              ),
              ListTile(
                title: const Text('Update question set'),
                onTap: () {
                  // Add your logic to update the quiz set
                  Navigator.of(ctx).pop();
                },
              ),
              ListTile(
                title: const Text('Test'),
                onTap: () {
                  // Add your logic for testing
                  Navigator.of(ctx).pop();
                },
              ),
              ListTile(
                title: const Text('Flash card'),
                onTap: () {
                  // Add your logic for flash cards
                  Navigator.of(ctx).pop();
                },
              ),
              ListTile(
                title: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  _removeQuiz(quizSet);
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _addQuiz(QuizSet newQuizSet) {
    setState(() {
      _registeredQuizzes.add(newQuizSet);
    });
  }

  void _showAddQuizForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => QuizForm(onCreated: _addQuiz,),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: const Text('Quiz Card'),
        backgroundColor: Colors.purple[500],
      ),
      body: _registeredQuizzes.isEmpty
          ? const Center(
              child: Text(
                'No quizzes added yet. Start adding some!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _registeredQuizzes.length,
              itemBuilder: (ctx, index) {
                final quizSet = _registeredQuizzes[index];
                return GestureDetector(
                  onTap: () => _showQuizOptions(quizSet), // Show the options on tap
                  child: ReuseCard(
                    title: quizSet.title,
                    description: quizSet.description,
                    borderColor: _getBorderColor(index),
                    actionWidget: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeQuiz(quizSet),
                    ),
                  )
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddQuizForm,
        backgroundColor: Colors.purple[500],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
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


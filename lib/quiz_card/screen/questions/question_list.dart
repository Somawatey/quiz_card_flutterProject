import 'package:flutter/material.dart';
import 'package:quiz_card_project/quiz_card/class_model/quiz_set.dart';
import 'package:quiz_card_project/quiz_card/screen/questions/question.dart';


class QuestionListScreen extends StatefulWidget {
  final QuizSet quizSet;

  const QuestionListScreen({super.key, required this.quizSet});

  @override
  State<QuestionListScreen> createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
  void _addQuestion() async {
    final question = await Navigator.push<Question>(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionScreen(
          onQuestionAdded: (newQuestion) => Navigator.pop(context, newQuestion),
          mode: EditionMode.creating,
        ),
      ),
    );

    if (question != null) {
      setState(() {
        widget.quizSet.questions.add(question);
      });
      _showSnackBar('Question added successfully!');
    }
  }
  void _editQuestion(Question question) async {
    final editedQuestion = await Navigator.push<Question>(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionScreen(
          onQuestionAdded: (updatedQuestion) => Navigator.pop(context, updatedQuestion),
          mode: EditionMode.editing,
          questionToEdit: question,
        ),
      ),
    );

    if (editedQuestion != null) {
      setState(() {
        final index = widget.quizSet.questions.indexOf(question);
        widget.quizSet.questions[index] = editedQuestion;
      });
      _showSnackBar('Question updated successfully!');
    }
  }
  void _deleteQuestion(Question question, int index) {
    final removedQuestion = widget.quizSet.questions.removeAt(index);
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Question removed'),
            action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
            setState(() {
            widget.quizSet.questions.insert(index, removedQuestion);
           });
          },
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quizSet.title),
        backgroundColor: Colors.blue[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addQuestion,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.quizSet.questions.length,
        itemBuilder: (context, index) {
          final question = widget.quizSet.questions[index];
          return Dismissible(
            key: Key(question.questionTitle), // Use unique key based on question title
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _deleteQuestion(question, index),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: GestureDetector(
              onTap: () => _editQuestion(question),
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.questionTitle,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...question.answers.asMap().entries.map((entry) {
                        final idx = entry.key;
                        final option = entry.value;
                        return Text(
                          '${idx + 1}. $option',
                          style: TextStyle(
                            color: option == question.correctAnswer
                                ? Colors.green
                                : Colors.black,
                          ),
                        );
                      }).toList(),
                      ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:quiz_card_project/quiz_card/class_model/quiz_set.dart';

class AddQuestionScreen extends StatefulWidget {
  final QuizSet quizSet;
  final Function(QuizSet, Question) onQuestionAdded;

  const AddQuestionScreen({
    super.key,
    required this.quizSet,
    required this.onQuestionAdded,
  });

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final _questionController = TextEditingController();
  final _answerControllers = [TextEditingController(), TextEditingController(), TextEditingController()];
  final _multipleAnswers = [false, false, false];

  void _saveQuestion() {
    // Create a new question object
    final newQuestion = Question(
      questionText: _questionController.text,
      answers: _answerControllers.map((controller) => controller.text).toList(),
      correctAnswers: _multipleAnswers,
    );

    // Add the question to the specific quiz
    widget.onQuestionAdded(widget.quizSet, newQuestion);

    // Close the screen after saving
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Question'),
        backgroundColor: Colors.purple[500],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _questionController,
              decoration: const InputDecoration(labelText: 'Question'),
            ),
            const SizedBox(height: 20),
            const Text('Multiple Answers', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: _answerControllers.length,
                itemBuilder: (ctx, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _answerControllers[index],
                          decoration: InputDecoration(labelText: 'Answer ${index + 1}'),
                        ),
                      ),
                      Checkbox(
                        value: _multipleAnswers[index],
                        onChanged: (value) {
                          setState(() {
                            _multipleAnswers[index] = value!;
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _saveQuestion,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple[500]),
              child: const Text('Save Question', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quiz_card_project/quiz_card/class_model/quiz_set.dart';
import 'package:quiz_card_project/quiz_card/widget/custom_button.dart';

class QuestionScreen extends StatefulWidget {
  final QuizSet quizSet;
  final Function(QuizSet, Question) onQuestionAdded;

  const QuestionScreen({
    super.key,
    required this.quizSet,
    required this.onQuestionAdded,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final _questionController = TextEditingController();
  final _answerControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  final _multipleAnswers = [false, false, false, false];
  int? _correctAnswerIndex; // Track the correct answer index

  void _saveQuestion() {
    if (_questionController.text.isEmpty ||
        _answerControllers.any((controller) => controller.text.isEmpty) ||
        _correctAnswerIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and select a correct answer!')),
      );
      return;
    }

    final newQuestion = Question(
      questionTitle: _questionController.text,
      answers: _answerControllers.map((controller) => controller.text).toList(),
      correctAnswer: _answerControllers[_correctAnswerIndex!].text, // Use correct answer from the selected index
    );

    widget.onQuestionAdded(widget.quizSet, newQuestion);
    Navigator.of(context).pop();
  }

  // New function to add another question
  void _addAnotherQuestion() {
    setState(() {
      _questionController.clear();
      for (var controller in _answerControllers) {
        controller.clear();
      }
      _multipleAnswers.fillRange(0, _multipleAnswers.length, false);
      _correctAnswerIndex = null; // Reset the correct answer index
    });
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
                            // Ensure only one correct answer can be selected
                            if (value == true) {
                              // Set all to false first, then select the clicked one
                              _multipleAnswers.fillRange(0, _multipleAnswers.length, false);//use fillRange to set all to false
                              _multipleAnswers[index] = true;
                              _correctAnswerIndex = index; // Track the correct answer index
                            } else {
                              _multipleAnswers[index] = false;
                              _correctAnswerIndex = null; // Reset if unchecked
                            }
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              children: [
                const Spacer(),
                ReuseButton(
                onPress: _addAnotherQuestion,
                icon: Icons.add, // Choose an icon
                label: 'Add MoreQuestion', 
                color: Colors.purple[300]!, 
              ),
                const Spacer(),
                ReuseButton(
                  onPress: _saveQuestion,
                  icon: Icons.check, // Checkmark icon
                  label: ' Save All Question ',
                  color: Colors.purple[500]!,
                ),
                const Spacer(),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}

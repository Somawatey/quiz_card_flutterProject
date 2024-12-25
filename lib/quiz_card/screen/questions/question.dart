import 'package:flutter/material.dart';
import 'package:quiz_card_project/quiz_card/class_model/quiz_set.dart';
import 'package:quiz_card_project/quiz_card/widget/custom_button.dart';

class QuestionScreen extends StatefulWidget {
  final Function(Question) onQuestionAdded;
  final Question? questionToEdit;
  final EditionMode mode;
  const QuestionScreen({super.key, required this.onQuestionAdded,this.questionToEdit, this.mode=EditionMode.creating});

  @override
  State createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final _questionController = TextEditingController();
  final _answerControllers = List.generate(4, (_) => TextEditingController());
  final _multipleAnswers = [false, false, false, false];
  int? _correctAnswerIndex;

  void _saveQuestion({bool addAnother = false}) {
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
    correctAnswer: _answerControllers[_correctAnswerIndex!].text,
  );

  widget.onQuestionAdded(newQuestion);

  if (addAnother) {
    // Clear the form for adding another question
    _clearForm();
  } else {
    // Pop the screen after saving the question
    //Navigator.of(context).pop();
    Navigator.of(context).popUntil((route) => route.isCurrent); 
  }
}

  void _clearForm() {
    setState(() {
      _questionController.clear();
      for (var controller in _answerControllers) {
        controller.clear();
      }
      _multipleAnswers.fillRange(0, _multipleAnswers.length, false);
      _correctAnswerIndex = null;
    });
  }
   @override
  void initState() {
    super.initState();
    if (widget.mode == EditionMode.editing && widget.questionToEdit != null) {
      _questionController.text = widget.questionToEdit!.questionTitle;
      for (var i = 0; i < widget.questionToEdit!.answers.length; i++) {
        _answerControllers[i].text = widget.questionToEdit!.answers[i];
        if (widget.questionToEdit!.answers[i] == widget.questionToEdit!.correctAnswer) {
          _correctAnswerIndex = i;
          _multipleAnswers[i] = true;
        }
      }
    }
  }
  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }
  bool get editingMode => widget.mode == EditionMode.editing;
  bool get creatingMode => widget.mode == EditionMode.creating;

  String get buttonLabel => creatingMode ? "Add" : "Edit";
  String get headerLabel => creatingMode ? "Add a new quiz set" : "Edit quiz set";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(headerLabel),
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
            const Text('Option Answers', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: _answerControllers.length,
                itemBuilder: (ctx, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _answerControllers[index],
                          decoration: InputDecoration(labelText: 'Option ${index + 1}'),
                        ),
                      ),
                      Checkbox(
                        value: _multipleAnswers[index],
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              _multipleAnswers.fillRange(0, _multipleAnswers.length, false);
                              _multipleAnswers[index] = true;
                              _correctAnswerIndex = index;
                            } else {
                              _multipleAnswers[index] = false;
                              _correctAnswerIndex = null;
                            }
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 150,
                child: ReuseButton(
                  onPress: _clearForm,
                  icon: Icons.refresh,
                  label: 'Reset',
                  color: Colors.red[300]!,
                ),
              ),

              SizedBox(
                width: 150,
                child: ReuseButton(
                  onPress: () => _saveQuestion(addAnother: true), // Save and clear form
                  icon: Icons.add,
                  label: 'Add More',
                  color: Colors.blue[400]!,
                ),
              ),
              SizedBox(
                width: 150, // Fixed width for all buttons
                child: ReuseButton(
                  onPress: () => _saveQuestion(addAnother: false), // Save and pop
                  icon: Icons.save,
                  label: buttonLabel,
                  color: Colors.purple[400]!,
                ),
              ),

            ],
          ),

          ],
        ),
      ),
    );
  }
}



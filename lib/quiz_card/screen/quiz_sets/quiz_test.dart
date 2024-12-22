import 'package:flutter/material.dart';
import 'package:quiz_card_project/quiz_card/class_model/quiz_set.dart';
import 'package:quiz_card_project/quiz_card/class_model/submission.dart';
import 'package:quiz_card_project/quiz_card/screen/answer/result.dart';
import 'package:quiz_card_project/quiz_card/screen/answer/show_result.dart';
import 'package:quiz_card_project/quiz_card/widget/custom_button.dart';
import 'package:quiz_card_project/quiz_card/widget/custom_card.dart';

enum QuizState { notStarted, started, finished }

class QuizTestScreen extends StatefulWidget {
  final QuizSet quizSet;

  const QuizTestScreen({super.key, required this.quizSet});

  @override
  State<QuizTestScreen> createState() => _QuizTestScreenState();
}

class _QuizTestScreenState extends State<QuizTestScreen> {
  QuizState _quizState = QuizState.notStarted;
  int _currentQuestionIndex = 0;
  final Submission _submission = Submission();
  String? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    _startQuiz(); // Start the quiz automatically
  }

  void _startQuiz() {
    setState(() {
      _quizState = QuizState.started;
      _currentQuestionIndex = 0;
      _submission.answers.clear();
      _selectedAnswer = null;
    });
  }

  void _submitAnswer(String answer) {
    final question = widget.quizSet.questions[_currentQuestionIndex];
    final isCorrect = question.correctAnswer == answer;

    setState(() {
      _submission.addAnswer(Answer(
        userAnswer: answer,
        isCorrect: isCorrect,
      ));

      if (_currentQuestionIndex < widget.quizSet.questions.length - 1) {
        _currentQuestionIndex++;
        _selectedAnswer = null;
      } else {
        _quizState = QuizState.finished;
        _showResults(); // Show results immediately after finishing the quiz
      }
    });
  }


  
  void _showResults() {
    final correctAnswers = _submission.answers
        .where((answer) => answer.isCorrect)
        .map((answer) => {
              'question': widget.quizSet.questions[_submission.answers.indexOf(answer)].questionTitle,
              'userAnswer': answer.userAnswer,
            })
        .toList();

    final incorrectAnswers = _submission.answers
        .where((answer) => !answer.isCorrect)
        .map((answer) => {
              'question': widget.quizSet.questions[_submission.answers.indexOf(answer)].questionTitle,
              'userAnswer': answer.userAnswer,
            })
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          onDone: () {
            Navigator.of(context).popUntil((route) => route.isFirst); // Navigate back to home screen
          },
          onViewResult: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ShowResultScreen(
                  correctAnswers: correctAnswers,
                  incorrectAnswers: incorrectAnswers,
                ),
              ),
            );
          },
          correctAnswers: correctAnswers.length,
          incorrectAnswers: incorrectAnswers.length,
          onRestartQuiz: () {
            
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_quizState == QuizState.notStarted) {
      return const Center(child: CircularProgressIndicator());
    }

    final question = widget.quizSet.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Practise Screen"),
        backgroundColor: widget.quizSet.color,
      ),
      body: Column(
        children: [
          // Header with a title
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ReuseCard(
                    description: "Question ${_currentQuestionIndex + 1}",
                    title: question.questionTitle,
                  ),
                  const SizedBox(height: 20),

                  // Display answers as clickable options
                  ...question.answers.map((answer) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedAnswer = answer;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: _selectedAnswer == answer ? Colors.purple[100] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _selectedAnswer == answer ? Colors.purple : Colors.grey,
                          ),
                        ),
                        child: Text(
                          answer,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }).toList(),

                  const Spacer(),

                  // ReuseButton for the next question
                  ReuseButton(
                    onPress: _selectedAnswer != null
                        ? () => _submitAnswer(_selectedAnswer!)
                        : () {}, // Disable button if no answer selected
                    icon: Icons.arrow_forward,
                    label: _currentQuestionIndex < widget.quizSet.questions.length - 1
                          ? "Next" // Display "Next" for all but the last question
                          : "Result", // Display "Result" for the last question
                      color: Colors.purple,
                      
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
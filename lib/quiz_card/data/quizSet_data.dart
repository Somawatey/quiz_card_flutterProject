import 'package:flutter/material.dart';
import 'package:quiz_card_project/quiz_card/class_model/quiz_set.dart';


final quizzes_data = [
    QuizSet(
      title: 'Flutter Basics',
      description: 'Learn the basics of Flutter framework.',
      date: DateTime.now(),
      color: Colors.green,
      questions: [
        Question(
        questionTitle: 'What is Flutter?',
        answers: ['A framework', 'A programming language', 'A database', 'An IDE'],
        correctAnswer: 'A framework',
      ),
      Question(
        questionTitle: 'Who developed Flutter?',
        answers: ['Google', 'Facebook', 'Microsoft', 'Apple'],
        correctAnswer: 'Google',
      ),
      ]
    ),
    QuizSet(
      title: 'Dart Syntax',
      description: 'A quick test on Dart syntax.',
      date: DateTime.now(),
      color: Colors.red,
      questions: [
        Question(
        questionTitle: 'What is Dart?',
        answers: ['A programming language', 'A framework', 'A database', 'An IDE'],
        correctAnswer: 'A programming language',
      ),
      Question(
        questionTitle: 'Which company developed Dart?',
        answers: ['Google', 'Facebook', 'Microsoft', 'Apple'],
        correctAnswer: 'Google',
      ),
      ]
    ),
    QuizSet(
      title: 'Advanced Flutter',
      description: 'Test your knowledge on advanced Flutter concepts.',
      date: DateTime.now(),
      color: Colors.blue,
      questions: [
      Question(
        questionTitle: 'What is a StatefulWidget?',
        answers: ['A widget with mutable state', 'A widget with immutable state', 'A stateless widget', 'A widget with no state'],
        correctAnswer: 'A widget with mutable state',
      ),
      Question(
        questionTitle: 'What is a StatelessWidget?',
        answers: ['A widget with immutable state', 'A widget with mutable state', 'A stateful widget', 'A widget with no state'],
        correctAnswer: 'A widget with immutable state',
      ),
    ],
    ),
    QuizSet(
      title: 'State Management',
      description: 'Test your knowledge on state management in Flutter.',
      date: DateTime.now(),
      color: Colors.purple,
      questions: [
      Question(
        questionTitle: 'What is Provider?',
        answers: ['A state management library', 'A database', 'An IDE', 'A programming language'],
        correctAnswer: 'A state management library',
      ),
      Question(
        questionTitle: 'What is setState?',
        answers: ['A method to update the state', 'A method to fetch data', 'A method to build widgets', 'A method to dispose widgets'],
        correctAnswer: 'A method to update the state',
      ),
    ],
    ),
  ];
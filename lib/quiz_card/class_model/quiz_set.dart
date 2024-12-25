import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum EditionMode { creating, editing }
enum QuizState { notStarted, started, finished }


class QuizSet {
  final String id;
  final String title;
  final String? description; // Make description optional
  final DateTime date;
  final Color color;
  List<Question> questions; // List of questions
  //final QuizMode mode;
  // Optional option for quiz actions

  QuizSet({
    required this.id,
    required this.title,
    required this.date,
    this.description, // Now optional
    required this.color,
    this.questions = const [], // Initialize with an empty list
    //this.mode = QuizMode.practice,  // Optional action
  }) ; //: id = uuid.v4()

  @override
  String toString() {
    return "Title: $title, Description: $description";
  }
}

class Question {
  final String questionTitle;
  final List<String> answers;
  final String correctAnswer;

  Question({
    required this.questionTitle,
    required this.answers,
    required this.correctAnswer, // List of correct answers
  });
}

class Answer {
  final String userAnswer;
  final bool isCorrect;

  Answer({
    required this.userAnswer,
    this.isCorrect = false,
  });
}

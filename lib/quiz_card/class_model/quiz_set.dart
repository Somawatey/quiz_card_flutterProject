import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum EditionMode { creating, editing }
enum QuizState { notStarted, started, finished }


class QuizSet {
  final String id;
  final String title;
  final String? description; 
  final DateTime date;
  final Color color;
  List<Question> questions;
  

  QuizSet({
    required this.id,
    required this.title,
    required this.date,
    this.description,
    required this.color,
    this.questions = const [],
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
    required this.correctAnswer, 
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

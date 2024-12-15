//import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum QuizOption {
  adding, editing, deleting, testing, learning
  
}

class QuizSet {
  final String id;
  final String title;
  String description;
  final DateTime date;
  List<Question> questions; // Add a list of questions
  //final QuizOption options;
  QuizSet({
    required this.title,
    required this.date,
    required this.description,
    this.questions = const [], // Initialize with an empty list
    //required this.options,

  }) : id = uuid.v4();

  
  @override
  String toString() {
    return "title $title , description $description";
  }
}

class Question {
  final String questionText;
  final List<String> answers;
  final List<bool> correctAnswers;

  Question({
    required this.questionText,
    required this.answers,
    required this.correctAnswers,
  });
}
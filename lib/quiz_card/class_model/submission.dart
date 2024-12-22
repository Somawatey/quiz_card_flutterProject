import 'package:quiz_card_project/quiz_card/class_model/quiz_set.dart';

class Submission {
  final List<Answer> answers = [];
  void addAnswer(Answer answer) {
    answers.add(answer);
  }

  void removeAnswer(Answer answer) {
    answers.remove(answer);
  }

  int getScore() {
    int score = 0;
    for (var answer in answers) {
      if (answer.isCorrect) score++;
    }
    return score;
  }

  Answer? getAnswerFor(Question question) {
    for (var answer in answers) {
      if (answer.userAnswer == question.correctAnswer) //compare the answer u choose with the format answer in question that we have
      return answer;
    }

    return null;
  }
}
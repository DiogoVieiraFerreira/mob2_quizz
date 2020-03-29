import 'package:flutter/foundation.dart';
import 'package:quiz/models/question.dart';

class QuizSession with ChangeNotifier {
  var _questions = [
    Question("H2G2", ["Some", "Other", "Thing"], "Other"),
    Question("Je suis ton père", ["Star Wars", "Bisounours", "Thing"], "Star Wars"),
  ];

  var _currentQuestionIndex = 0;

  Question get currentQuestion => _questions[_currentQuestionIndex];

  void nextQuestion() {
    _currentQuestionIndex = (_currentQuestionIndex + 1) % _questions.length;
    notifyListeners();
  }

  bool checkAnswer(String answer) {
    return _questions[_currentQuestionIndex].isCorrectAnswer(answer);
  }
}

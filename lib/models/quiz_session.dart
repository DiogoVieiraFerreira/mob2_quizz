import 'package:flutter/foundation.dart';
import 'package:quiz/models/question.dart';

class QuizSession with ChangeNotifier {
  var _score = 0;
  var _questions = [
    Question("2 + 2", ["1", "2", "4"], "4", "come on"),
    Question("Meaning of life?", ["God", "42", "Me"], "42", "H2G2"),
    Question("May the Force be with you", ["Star Wars", "Forest Gump", "American Pie"], "Star Wars", "Skywalker"),
  ];

  var _currentQuestionIndex = 0;
  bool _showHint = false;
  bool get showHint => _showHint;
  int get score => _score;
  int get length => _questions.length;
  Question get currentQuestion => _questions[_currentQuestionIndex];
  Question get lastQuestion => _questions[_questions.length-1];

  bool completed = false;

  void nextQuestion() {
    _currentQuestionIndex++;
    _showHint = false;
    if(_currentQuestionIndex > length-1)
      completed = true;
    notifyListeners();
  }

  bool isCompleted(){
    return completed;
  }

  bool hintRequested(){
    _showHint = !_showHint;
    notifyListeners();
    return _showHint;
  }

  bool checkAnswer(String answer) {
    if(currentQuestion.isCorrectAnswer(answer))
    {
      _score++;
      return true;
    }
    return false;
  }
}

import 'package:flutter/foundation.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/models/question_repository.dart';

enum QuizSessionState {
  loading,
  showing,
  error,
  completed,
}

class QuizSession with ChangeNotifier {
  QuestionRepository _questionRepository;
  Question _currentQuestion;
  int _totalQuestions;
  int _currentQuestionCount = 0;
  bool _showHint;
  QuizSessionState _state;
  int score = 0; //modify only this var in inheritances

  QuizSession({QuestionRepository questionRepository, @required int totalQuestions}) {
    _state = QuizSessionState.loading;
    _questionRepository = questionRepository;
    _totalQuestions = totalQuestions;
    _showHint = false;
  }

  void nextQuestion() async {
    _currentQuestionCount++;
    _showHint = false;
    try {
      if (_currentQuestionCount > _totalQuestions)
        return endGame();
      else {
        _state = QuizSessionState.loading;
        notifyListeners();
        _currentQuestion = await _questionRepository.fetch();
        _state = QuizSessionState.showing;
      }
    } catch (e) {
      _state = QuizSessionState.error;
      print(e);
    }
    notifyListeners();
  }

  void toggleHint() {
    _showHint = !_showHint;
    notifyListeners();
  }

  bool checkAnswer(String answer) {
    return currentQuestion.isCorrectAnswer(answer);
  }

  void endGame(){
    _state=QuizSessionState.completed;
    notifyListeners();
  }
  
  QuizSessionState get state => _state;
  bool get showHint => _showHint;
  Question get currentQuestion => _currentQuestion;
  int get totalQuestions => _totalQuestions;
}

import 'package:flutter/foundation.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/models/question_repository.dart';
enum QuizSessionState {
  loading,
  showing,
  completed,
}

class QuizSession with ChangeNotifier {
  QuestionRepository _questionRepository;
  Question _currentQuestion;
  int _totalQuestions;
  int _currentQuestionCount = 0;
  bool _showHint;
  QuizSessionState _state;
  int _score = 0;

  QuizSession({QuestionRepository questionRepository, @required int totalQuestions}) {
    _state = QuizSessionState.loading;
    _questionRepository = questionRepository;
    _totalQuestions = totalQuestions;
    _showHint = false;
  }

  void nextQuestion() async{
    _currentQuestionCount++;
    _showHint = false;
    try{
      if(_currentQuestionCount > _totalQuestions)
        _state = QuizSessionState.completed;
      else{
        _state = QuizSessionState.loading;
        notifyListeners();
        _currentQuestion = await _questionRepository.fetch();
        _state = QuizSessionState.showing;
      }
    }
    catch(e){
      print("caca "+e);
    }
    notifyListeners();
  }

  void toggleHint(){
    _showHint = !_showHint;
    notifyListeners();
  }

  bool checkAnswer(String answer) {
    if(currentQuestion.isCorrectAnswer(answer))
    {
      _score++;
      return true;
    }
    return false;
  }

  QuizSessionState get state => _state;
  bool get showHint => _showHint;
  int get score => _score;
  Question get currentQuestion => _currentQuestion;
  int get totalQuestions => _totalQuestions;

}

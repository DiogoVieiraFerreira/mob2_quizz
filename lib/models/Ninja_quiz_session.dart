import 'dart:async';

import 'package:quiz/models/question_repository.dart';

import 'quiz_session.dart';

class NinjaQuizSession extends QuizSession {
  Timer timer;
  bool _answer = true;

  NinjaQuizSession({QuestionRepository questionRepository}): super(questionRepository: questionRepository, totalQuestions: 15) {
    gameTimeout(30);
    questionTimeout();
  }

  bool checkAnswer(String answer) {
    _answer = super.checkAnswer(answer);
    if (_answer) {
      score++;
      return true;
    }
    score--;
    return false;
  }

  void nextQuestion() {
    if(state == QuizSessionState.completed)
      timer.cancel();
    if (_answer) {
      super.nextQuestion();
      questionTimeout();
    }
  }

  gameTimeout([int seconds = 10]) {
    return Timer(Duration(seconds: seconds), endGame);
  }

  questionTimeout([int seconds = 3]) {
    if (timer != null) timer.cancel();
    timer = Timer.periodic(Duration(seconds: seconds), (Timer t) => super.nextQuestion());
  }
}

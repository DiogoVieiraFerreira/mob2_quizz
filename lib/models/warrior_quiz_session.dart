import 'dart:async';

import 'package:quiz/models/question.dart';
import 'package:quiz/models/question_repository.dart';

import 'quiz_session.dart';

class WarriorQuizSession extends QuizSession {

  bool _answer=true;
  WarriorQuizSession({QuestionRepository questionRepository}): super(questionRepository: questionRepository, totalQuestions: 15){
    endGameTimeout(30);
  }

  bool checkAnswer(String answer) {
    _answer = super.checkAnswer(answer);
    if(_answer)
    {
      score++;
      return true;
    }
    score--;
    return false;
  }

  void nextQuestion(){
    if(_answer)
      super.nextQuestion();
  }

  endGameTimeout([int seconds = 10]) {
    return Timer(Duration(seconds: seconds), endGame);
  }
}
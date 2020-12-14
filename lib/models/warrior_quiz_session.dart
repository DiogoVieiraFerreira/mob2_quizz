import 'dart:async';

import 'package:quiz/models/journeyman_quiz_session.dart';
import 'package:quiz/models/question_repository.dart';


class WarriorQuizSession extends JourneymanQuizSession {
  WarriorQuizSession({QuestionRepository questionRepository}): super(questionRepository: questionRepository, totalQuestions: 15){
    endGameTimeout(30);
  }

  endGameTimeout([int seconds = 10]) {
    return Timer(Duration(seconds: seconds), endGame);
  }
}
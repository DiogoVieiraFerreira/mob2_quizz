import 'dart:async';

import 'package:quiz/models/question_repository.dart';
import 'package:quiz/models/warrior_quiz_session.dart';

import 'quiz_session.dart';

class NinjaQuizSession extends WarriorQuizSession {
  Timer timer;

  NinjaQuizSession({QuestionRepository questionRepository}): super(questionRepository: questionRepository) {
    questionTimeout();
  }

  void nextQuestion() {
    if (state == QuizSessionState.completed)
      timer.cancel();

    super.nextQuestion();
    questionTimeout();
  }
  questionTimeout([int seconds = 3]) {
    if (timer != null) timer.cancel();
    timer = Timer(Duration(seconds: seconds), super.nextQuestion);
  }
}

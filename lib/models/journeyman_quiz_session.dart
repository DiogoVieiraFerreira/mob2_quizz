import 'package:quiz/models/question.dart';
import 'package:quiz/models/question_repository.dart';

import 'quiz_session.dart';

class JourneymanQuizSession extends QuizSession {
  bool _answer=true;
  JourneymanQuizSession({QuestionRepository questionRepository}): super(questionRepository: questionRepository, totalQuestions: 10);
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
}
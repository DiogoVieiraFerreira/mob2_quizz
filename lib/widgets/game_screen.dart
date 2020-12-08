import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/models/Ninja_quiz_session.dart';
import 'package:quiz/models/Remote_question_repository.dart';

import 'package:quiz/models/quiz_session.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // QuizSession session = QuizSession(questionRepository: new LocalQuestionRepository(),totalQuestions: 4 );
    // QuizSession session = RookieQuizSession(questionRepository: new RemoteQuestionRepository("http://192.168.1.103:4567/questions/next"));
    // QuizSession session = JourneymanQuizSession(questionRepository: new RemoteQuestionRepository("http://192.168.1.103:4567/questions/next"));
    QuizSession session = NinjaQuizSession(questionRepository: new RemoteQuestionRepository("http://192.168.1.103:4567/questions/next"));
    session.nextQuestion();

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: ChangeNotifierProvider.value(
        value: session,
        child: Consumer<QuizSession>(
          builder: (consumerContext, session, __) {
            switch(session.state) {
              case QuizSessionState.loading:
                return buildLoading();
              case QuizSessionState.showing:
                return buildQuestion(consumerContext, session);
              case QuizSessionState.completed:
                return buildEndGame(context, session);
              default:
                return buildErrorPage(context);
            }
          },
        ),
      ),
    );
  }

  Widget buildEndGame(BuildContext context, QuizSession session) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        buildScore(context, session),
        ElevatedButton(onPressed: () => Navigator.pushReplacementNamed(context, "/"), child: Text("restart"))
      ]),
    );
  }
  Widget buildErrorPage(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("An Error Occured... check your access Internet or retry later."),
        ElevatedButton(onPressed: () => Navigator.pushReplacementNamed(context, "/"), child: Text("restart"))
      ]),
    );
  }

  Widget buildLoading() {
    return Center(
        child: CircularProgressIndicator()
    );
  }
  Widget buildQuestion(BuildContext context, QuizSession session) {
    var answerButtons = session.currentQuestion.answers.map((answer) {
      return ElevatedButton(
          onPressed: () {
            session.checkAnswer(answer);
            session.nextQuestion();
          },
          child: SizedBox(
              width: double.infinity,
              child: Text(answer,
                  textScaleFactor: 2.0, textAlign: TextAlign.center)));
    });

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(session.currentQuestion.caption, textScaleFactor: 2.0),
          Visibility(
            child: Text("Hint: ${session.currentQuestion.hint}",
                textScaleFactor: 1.0, textAlign: TextAlign.center),
            visible: session.showHint,
          ),
          ...answerButtons,
          buildHint(context, session)
        ],
      ),
    );
  }

  Widget buildHint(BuildContext context, QuizSession session) {
    return Center(
      child: FloatingActionButton(
        onPressed: () => session.toggleHint(),
        child: Icon(Icons.help_outline),
        backgroundColor: Theme.of(context).accentColor,
      ),    
    );    
  }

  Widget buildScore(BuildContext context, QuizSession session) {
    return Center(
      child: Column(
        children: [
          Text("Total Questions: ${session.totalQuestions}",
              textScaleFactor: 2, textAlign: TextAlign.center),
          Text("Your Score: ${session.score}",
              textScaleFactor: 2, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

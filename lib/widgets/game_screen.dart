import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quiz/models/quiz_session.dart';

class GameScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final  Map<String, QuizSessionType>routeParams = ModalRoute.of(context).settings.arguments;
    QuizSession session = QuizSession.fromEnum(routeParams["type"]);
    session.nextQuestion();

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz with ${session.totalQuestions} questions"),
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
            if (session.checkAnswer(answer))
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
          // Text("question "+ session.currentQuestionCount.toString(),  textScaleFactor: 1.0, textAlign: TextAlign.start),
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

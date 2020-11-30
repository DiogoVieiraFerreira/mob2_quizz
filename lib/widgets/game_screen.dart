import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quiz/models/quiz_session.dart';
import 'package:quiz/models/question.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: ChangeNotifierProvider(
        create: (_) => QuizSession(),
        child: Consumer<QuizSession>(
          builder: (consumerContext, session, __) {
            return session.isCompleted()
                ? buildEndGame(context, session)
                : buildQuestion(consumerContext, session);
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
        onPressed: () => session.hintRequested(),
        child: Icon(Icons.help_outline),
        backgroundColor: Theme.of(context).accentColor,
      ),    
    );    
  }

  Widget buildScore(BuildContext context, QuizSession session) {
    return Center(
      child: Column(
        children: [
          Text("Total Questions: ${session.length}",
              textScaleFactor: 2, textAlign: TextAlign.center),
          Text("Your Score: ${session.score}",
              textScaleFactor: 2, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

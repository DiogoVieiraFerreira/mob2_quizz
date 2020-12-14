import 'package:flutter/material.dart';
import 'package:quiz/models/quiz_session.dart';

class GameList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Quiz List"),
        ),
        body: ListQuiz(),
    );
  }

  Widget ListQuiz() {
    var quizzButtons = QuizSessionType.values.map((type) {
      return ElevatedButton(
          onPressed: () {
            QuizSession session = QuizSession.fromEnum(type);
            print(session);
          },
          child: Text(
              type?.toString()?.split('.')?.elementAt(1), textScaleFactor: 2.0,
              textAlign: TextAlign.center)
      );
    });
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ...quizzButtons,
        ],
      ),
    );
  }
}
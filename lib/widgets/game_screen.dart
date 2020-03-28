import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quiz/models/quiz_session.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: Provider(
        create: (_) => QuizSession(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer<QuizSession>(
                builder: (_, session, __) => Text(session.label),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text('La réponse 1'),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text('La réponse 2'),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text('La réponse 3'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

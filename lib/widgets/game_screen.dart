import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'This is the question',
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
    );
  }
}

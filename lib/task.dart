import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
  final title;
  final description;

  TaskPage({@required this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(description),
            RaisedButton(
              child: Text('Back To HomeScreen'),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () => Navigator.pop(context),
            )
          ],
        )
      )
    );
  }
}
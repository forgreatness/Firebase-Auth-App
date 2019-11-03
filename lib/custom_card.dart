import 'package:flutter/material.dart';
import 'package:firebase_auth_app/task.dart';

class CustomCard extends StatelessWidget {
  final title;
  final description;

  CustomCard({@required this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          children: <Widget>[
            Text(title),
            FlatButton(
              child: Text("See More"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskPage(
                      title: title,
                      description: description,
                    )
                  )
                );
              },
            )
          ],
        )
      )
    );
  }
}
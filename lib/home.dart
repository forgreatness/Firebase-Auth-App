import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_auth_app/custom_card.dart';

class HomePage extends StatefulWidget {
  final String title;
  final String uid;
  final FacebookLogin facebookLogin;
  final GoogleSignIn googleSignIn;

  HomePage({Key key, this.title, this.uid, this.facebookLogin, this.googleSignIn}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  TextEditingController taskTitleInputController;
  TextEditingController taskDescriptionInputController;
  FirebaseUser currentUser;

  @override
  void initState() {
    taskTitleInputController = new TextEditingController();
    taskDescriptionInputController = new TextEditingController();
    this.getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          FlatButton(
            child: Text("Log Out"),
            textColor: Colors.white,
            onPressed: () {
              if (currentUser.providerData[1].providerId == 'facebook.com') {
                widget.facebookLogin.logOut();
              } else if(currentUser.providerData[1].providerId == 'google.com') {
                widget.googleSignIn.signOut();
              }
              FirebaseAuth.instance
              .signOut()
              .then((result) => Navigator.pushReplacementNamed(context, "/login"))
              .catchError((err) => print(err));
            },
          )
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
              .collection('users')
              .document(widget.uid)
              .collection('tasks')
              .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return new Text('Error ${snapshot.error}');
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text('Loading...');
                default:
                  return new ListView(
                    children: snapshot.data.documents.map((DocumentSnapshot document) {
                      return new CustomCard(
                        title: document['title'],
                        description: document['description'],
                      );
                    }).toList(),
                  );
              }
            }
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Column(
          children: <Widget>[
            Text('Please fill all fields to create a new task'),
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Task Title*'
                ),
                controller: taskTitleInputController,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: 'Task Description*'),
                controller: taskDescriptionInputController,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              taskTitleInputController.clear();
              taskDescriptionInputController.clear();
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text('Add'),
            onPressed: () {
              if (taskDescriptionInputController.text.isNotEmpty && taskTitleInputController.text.isNotEmpty) {
                Firestore.instance
                  .collection('users')
                  .document(widget.uid)
                  .collection('tasks')
                  .add({
                    'title': taskTitleInputController.text,
                    'description': taskDescriptionInputController.text,
                  })
                  .then((result) => {
                    Navigator.pop(context),
                    taskTitleInputController.clear(),
                    taskDescriptionInputController.clear(),
                  })
                  .catchError((err) => print(err));
              }
            },
          )
        ],
      )
    );
  }
}
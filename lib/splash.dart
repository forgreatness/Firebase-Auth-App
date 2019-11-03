import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth_app/home.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super (key: key);

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    FirebaseAuth.instance
      .currentUser()
      .then((currentUser) => {
        if (currentUser == null) {
          Navigator.pushReplacementNamed(context, '/login')
        }
        else {
          Firestore.instance
          .collection("users")
          .document(currentUser.uid)
          .get()
          .then((DocumentSnapshot result) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                title: result["fname"] + "'s Tasks",
                uid: currentUser.uid,
              )
            )
          ))
        }
      })
      .catchError((err) => print(err));
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Loading..."),
        ),
      ),
    );
  }
}
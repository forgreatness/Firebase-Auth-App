import 'package:flutter/material.dart';

import 'package:firebase_auth_app/splash.dart';
import 'package:firebase_auth_app/home.dart';
import 'package:firebase_auth_app/task.dart';
import 'package:firebase_auth_app/register.dart';
import 'package:firebase_auth_app/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/task': (BuildContext context) => TaskPage(title: 'Task'),
        '/home': (BuildContext context) => HomePage(title: 'Home'),
        '/login': (BuildContext context) => LoginPage(),
        '/register': (BuildContext context) => RegisterPage(),
      }
    );
  }
}
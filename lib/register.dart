import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth_app/home.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;

  @override
  void initState() {
    firstNameInputController = new TextEditingController();
    lastNameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _registerFormKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'First name*',
                    hintText: 'Danh',
                  ),
                  controller: firstNameInputController,
                  validator: (value) {
                    if (value.length < 3) {
                      return "Please enter a valid first name";
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Last Name*',
                    hintText: 'Nguyen',
                  ),
                  controller: lastNameInputController,
                  validator: (value) {
                    if (value.length < 3) {
                      return "Please enter a valid last name";
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email*',
                    hintText: 'danh@gmail.com',
                  ),
                  controller: emailInputController,
                  validator: emailValidator,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password*',
                    hintText: '**********',
                  ),
                  controller: pwdInputController,
                  validator: pwdValidator,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirm Password*',
                    hintText: '**********',
                  ),
                  controller: confirmPwdInputController,
                  validator: pwdValidator,
                ),
                RaisedButton(
                  child: Text("Register"),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    if (_registerFormKey.currentState.validate()) {
                      if (pwdInputController.text == confirmPwdInputController.text) {
                        FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                            email: emailInputController.text,
                            password: pwdInputController.text
                          )
                          .then((currentUser) => Firestore.instance
                            .collection('users')
                            .document(currentUser.user.uid)
                            .setData({
                              'uid': currentUser.user.uid,
                              'fname': firstNameInputController.text,
                              'surname': lastNameInputController.text,
                              'email': emailInputController.text,
                            })
                            .then((result) => {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(
                                    title: firstNameInputController.text + "'s Tasks",
                                    uid: currentUser.user.uid,
                                  )
                                ),
                                (_) => false
                              ),
                            })
                            .catchError((err) => print(err)))
                          .catchError((err) => print(err));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('The passwords do not match'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Close'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          }
                        );
                      }
                    }
                  },
                ),
                Text('Already have an account?'),
                FlatButton(
                  child: Text('Login Here!'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )
          )
        )
      )
    );
  }
}
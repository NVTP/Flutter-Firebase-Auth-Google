import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class RoleLoginPage extends StatefulWidget {
  @override
  _RoleLoginPageState createState() => _RoleLoginPageState();
}

class _RoleLoginPageState extends State<RoleLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: Center(
        child: RaisedButton(
          onPressed: (){
            FirebaseAuth.instance.signInWithEmailAndPassword(
                email: 'wow@gmail.com', password: 'aaaaaa');
          },
          elevation: 5.0,
          color: Colors.blue,
          textColor: Colors.white,
          child: Text('Login'),
        ),
      ),
    );
  }
}

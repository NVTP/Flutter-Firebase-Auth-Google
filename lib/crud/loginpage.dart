import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/crud/dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Sample'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration.collapsed(hintText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value){
                this.email = value;
              },
            ),
            SizedBox(height: 10,),
            TextField(
              decoration: InputDecoration.collapsed(hintText: 'Password'),
              onChanged: (value){
                this.password = value;
              },
              obscureText: true,
            ),
            SizedBox(height: 10,),
            RaisedButton(
              onPressed: (){
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                      email: this.email, password: this.password)
                    .then((signInUser){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard()));
                }).catchError((e){
                  print(e);
                });
              },
              textColor: Colors.white,
              child: Text('Login'),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

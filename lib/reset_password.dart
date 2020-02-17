import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyResetPasswordPage extends StatefulWidget {
  @override
  _MyResetPasswordPageState createState() => _MyResetPasswordPageState();
}

class _MyResetPasswordPageState extends State<MyResetPasswordPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.green[50],
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [Colors.yellow[100],Colors.green[100]]
              )
            ),
            margin: EdgeInsets.all(34),
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButtonSignUp(BuildContext context){
    return InkWell(
      child: Container(
        constraints: BoxConstraints.expand(height: 50),
        child: Text('Reset Password',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Colors.white),),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.green[200]
        ),
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(12),
      ),
      onTap: ()=>resetPassword(),
    );
  }

  Container buildTextFieldEmail(){
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.yellow[50],borderRadius: BorderRadius.circular(16)
      ),
      child: TextField(
        controller: emailController,
        decoration: InputDecoration.collapsed(hintText: 'Email'),
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  resetPassword(){
    String email = emailController.text.trim();
    _auth.sendPasswordResetEmail(email: email);
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('we send the detail to $email successfully',style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.green[300],
    ));
  }
}

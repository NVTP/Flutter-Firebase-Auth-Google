import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/home_page.dart';

class MySignUpPage extends StatefulWidget {
  @override
  _MySignUpPageState createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  Future checkAuth(BuildContext context)async{
    FirebaseUser user = await _auth.currentUser();
    if(user != null){
      print('Already sign-up with');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(user)),
          ModalRoute.withName('/'));
    }
  }

    signUp(){
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmController.text.trim();
    if(password == confirmPassword && password.length >= 6){
      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user){
            print('Sign up user successfully');
            checkAuth(context);
      }).catchError((error){
        print(error.message);
      });
    }else{
      print('Password and Confirm-password is not match');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        centerTitle: true,
        title: Text('Sign up',style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.green[50],
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [Colors.yellow[100],Colors.green[100]]
                ),
              ),
              margin: EdgeInsets.all(32),
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildTextFieldEmail(),
                  buildTextFieldPassword(),
                  buildTextFieldPasswordConfirm(),
                  buildButtonSignUp(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButtonSignUp(BuildContext context){
    return InkWell(
      onTap: ()=>signUp(),
      child: Container(
        constraints: BoxConstraints.expand(height: 50),
        child: Text('Sign up',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Colors.white),),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),color: Colors.green[200]
        ),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12),
      ),
    );
  }

  Container buildTextFieldEmail(){
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.yellow[50],borderRadius: BorderRadius.circular(16)
      ),
      child: TextField(
        decoration: InputDecoration.collapsed(hintText: 'Email'),
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontSize: 18),
        controller: emailController,
      ),
    );
  }

  Container buildTextFieldPassword(){
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.yellow[50],borderRadius: BorderRadius.circular(16)
      ),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration.collapsed(hintText: 'Password'),
        style: TextStyle(fontSize: 18),
        controller: passwordController,
      ),
    );
  }

  Container buildTextFieldPasswordConfirm(){
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
          color: Colors.yellow[50],borderRadius: BorderRadius.circular(16)
      ),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration.collapsed(hintText: 'Re-password'),
        style: TextStyle(fontSize: 18),
        controller: confirmController,
      ),
    );
  }
}

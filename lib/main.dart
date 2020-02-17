import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:login/my_login_page.dart';


void main(){
  runApp(MaterialApp(
    home: MyLoginPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyMainPage extends StatefulWidget {
  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLogged = false;

  Future _loginWithFacebok(BuildContext context)async{
    FacebookLogin facebookLogin = FacebookLogin();
    FacebookLoginResult result = await facebookLogin.logInWithReadPermissions(['email']);


    String token = result.accessToken.token;
    print('Acess token $token');
    await _auth.signInWithCredential(
      FacebookAuthProvider.getCredential(accessToken: token)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook Login '),
        centerTitle: true,
      ),
      body: Center(
        child: isLogged ? null : FacebookSignInButton(
          onPressed: ()=>_loginWithFacebok(context),
        ),
      ),
    );
  }
}

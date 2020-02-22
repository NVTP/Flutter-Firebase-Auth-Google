import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:login/crud/loginpage.dart';
import 'package:login/my_login_page.dart';
import 'package:login/profile/selectprofpic.dart';
import 'package:login/profile_page.dart';

//pages
import 'package:login/profile/homepage.dart';
import 'package:login/profile/loginpage.dart';
import 'package:login/profile/signuppage.dart';



void main(){
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyLoginPage(),
      routes: <String, WidgetBuilder>{
        '/landingpage': (BuildContext context)=> MyApp(),
        '/signup': (BuildContext context) => SignupPage(),
        '/homepage': (BuildContext context) => HomePage(),
        '/selectpic': (BuildContext context) => SelectprofilepicPage(),
      },
    );
  }
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

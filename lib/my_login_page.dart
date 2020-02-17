import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/home_page.dart';
import 'package:login/reset_password.dart';
import 'package:login/sign_up.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

//  void initState(){
//    super.initState();
//    checkAuth(context);
//  }

  Future checkAuth(BuildContext context)async{
    FirebaseUser user = await _auth.currentUser();
    if(user != null){
      print('Already sign-in with');
      Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context)=>MyHomePage(user))
      );
    }
  }

  Future<FirebaseUser> signIn() async {
    final FirebaseUser user = await _auth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((user){
      print('sign in ${_auth.toString()}');
      checkAuth(context);
    }).catchError((error){
      print(error.message);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(error.message, style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Firebase Again'),
        centerTitle: true,
        backgroundColor: Colors.green[200],
      ),
      backgroundColor: Colors.green[50],
      body: SafeArea(
        child: SingleChildScrollView(
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
                  children: <Widget>[
                    buildTextFieldEmail(),
                    buildTextFieldPassword(),
                    buildButtonSignIn(),
                    buildHaveAccount(),
                    buildButtonFacebook(context),
                    buildButtonGoogle(context),
                    buildButtonRegister(),
                    buildOtherLine(),
                    buildButtonForgotPassword(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget buildButtonSignIn(){
    return InkWell(
      onTap: signIn,
      child: Container(
        constraints: BoxConstraints.expand(height: 50),
        child: Text('Sign In',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Colors.white),),
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
        style: TextStyle(fontSize: 18),
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
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

  Widget buildHaveAccount(){
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Divider(color: Colors.green[800],),
          ),
          Padding(
            padding: EdgeInsets.all(6),
            child: Text('Don\'t have an account?',style: TextStyle(color: Colors.black87),),
          ),
          Expanded(
            child: Divider(color: Colors.green[800],),
          ),
        ],
      ),
    );
  }

  Widget buildOtherLine(){
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Divider(color: Colors.green[800],),
          ),
          Padding(
            padding: EdgeInsets.all(6),
            child: Text('Other',style: TextStyle(color: Colors.black87),),
          ),
          Expanded(
            child: Divider(color: Colors.green[800],),
          ),
        ],
      ),
    );
  }

  Widget buildButtonRegister(){
    return InkWell(
      onTap: (){
        Navigator.push(context,
        MaterialPageRoute(builder: (context)=>MySignUpPage())
        );
      },
      child: Container(
        constraints: BoxConstraints.expand(height: 50),
        child: Text('Sign up',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Colors.white),),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),color: Colors.orange[200]
        ),
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(12),
      ),
    );
  }

  buildButtonForgotPassword(BuildContext context){
    return InkWell(
      child: Container(
        constraints: BoxConstraints.expand(height: 50),
        child: Text('Forgot password',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Colors.white),),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.red[300]
        ),
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(12),
      ),
      onTap: ()=>navigateToResetPasswordPage(context),
    );
  }

  navigateToResetPasswordPage(BuildContext context){
    Navigator.push(context,
    MaterialPageRoute(builder: (context)=>MyResetPasswordPage())
    );
  }

  Widget buildButtonFacebook(BuildContext context){
    return InkWell(
      child: Container(
        constraints: BoxConstraints.expand(height: 50),
        child: Text('Login with Facebook',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18,color: Colors.white),),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.blue[400]
        ),
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(12),
      ),
      onTap: ()=>loginWithFacebook(context),
    );
  }

  Future loginWithFacebook(BuildContext context)async{
    FacebookLogin facebookLogin = FacebookLogin();
    FacebookLoginResult result = await facebookLogin.logInWithReadPermissions(['email', 'public_profile']);

    String token = result.accessToken.token;
    print('Access token = $token');
    await _auth.signInWithCredential(
      FacebookAuthProvider.getCredential(accessToken: token)
    );
    checkAuth(context);
  }

  Widget buildButtonGoogle(BuildContext context){
    return InkWell(
      child: Container(
        constraints: BoxConstraints.expand(height: 50),
        child: Text('Login with Google',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18,color: Colors.blue[600]),),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),color: Colors.white
        ),
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(12),
      ),
      onTap: ()=>loginWithGoogle(context),
    );
  }

  Future loginWithGoogle(BuildContext context)async{
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'https://www.googleapis.com/auth/contacts.readonly',
      ]
    );
    GoogleSignInAccount user = await _googleSignIn.signIn();
    GoogleSignInAuthentication userAuth = await user.authentication;

    await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: userAuth.idToken, accessToken: userAuth.accessToken));
    checkAuth(context);
  }
}

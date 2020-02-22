import 'package:flutter/material.dart';

//services
import 'services/usermanagement.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _email;
  String _password;
  String _nickName;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
      child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                  decoration: InputDecoration(hintText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  }),
              SizedBox(height: 15.0),
              TextField(
                  decoration: InputDecoration(hintText: 'Password'),
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  }),
              SizedBox(
                height: 15,
              ),
              TextField(
                decoration: InputDecoration.collapsed(hintText: 'Nick Name'),
                onChanged: (value) {
                  setState(() {
                    _nickName = value;
                  });
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text('Sign Up'),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _email, password: _password)
                      .then((signedInUser) async {
                    var userUpdateinfo = new UserUpdateInfo();
                    userUpdateinfo.displayName = _nickName;
                    userUpdateinfo.photoUrl =
                        'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg';
                    await signedInUser.user.updateProfile(userUpdateinfo);
                    await signedInUser.user.reload();
                    FirebaseUser updatedUser =
                        await FirebaseAuth.instance.currentUser();
                    print('Username is: ${updatedUser.displayName}');
                  }).then((user) {
                    FirebaseAuth.instance.currentUser().then((user) {
                      print('user1: ${user.photoUrl} : ok');
                      UserManagement().storeNewUser(user, context);
                    });
                  }).catchError((e) {
                    debugPrint(e);
                  });
                },
              ),
            ],
          )),
    ));
  }
}

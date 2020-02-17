import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/my_login_page.dart';

class MyHomePage extends StatefulWidget {
  final FirebaseUser user;
  MyHomePage(this.user);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void signOut(BuildContext context){
    _auth.signOut();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context)=>MyLoginPage()),
        ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        title: Text('Home'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            color: Colors.white,
            onPressed: (){
              signOut(context);
            },
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Hello',style: TextStyle(fontSize: 26),),
              Text(widget.user.email,style: TextStyle(fontSize: 16),)
            ],
          ),
        ),
      ),
    );
  }
}

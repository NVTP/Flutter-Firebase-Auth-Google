//Firebase packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:login/crud/loginpage.dart';
import 'package:login/role/role_adminonly.dart';

//Pages
import 'package:login/role/role_dashboard.dart';
import 'package:login/role/role_login.dart';

class UserManagement {
  Widget handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return RoleDashboardPage();
        }
        return RoleLoginPage();
      },
    );
  }

  //This Method for Signin to Another Page by role in firestore
  authoreizeAccess(BuildContext context) {
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('users')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
            if(docs.documents[0].exists){
              if(docs.documents[0].data['role'] == 'admin'){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>RoleAdminPage())
                );
              }else{
               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
              }
            }
      });
    });
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}

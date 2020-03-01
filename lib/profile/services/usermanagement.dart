import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/widgets.dart';

class UserManagement {
  storeNewUser(user, context) {
    Firestore.instance.collection('users').add({
      'email': user.email,
      'uid': user.uid,
      'displayName': user.displayName,
      'photoUrl': user.photoUrl
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/selectpic');
    }).catchError((e) {
      print(e);
    });
  }

  Future updateProfilePic(picUrl)  {
    var userInfo = new UserUpdateInfo();
    userInfo.photoUrl = picUrl;
    FirebaseAuth.instance.currentUser().then((user){
      user.updateProfile(userInfo);
    }).then((user){
      FirebaseAuth.instance.currentUser().then((user) {
        user.updateProfile(userInfo);
        Firestore.instance
            .collection('users')
            .where('uid', isEqualTo: user.uid)
            .getDocuments()
            .then((docs) {
          Firestore.instance
              .document('users/${docs.documents[0].documentID}')
              .updateData({'photoURL': picUrl}).then((val) {
            print('Update');
          }).catchError((e) {
            print(e);
          });
        }).catchError((e) {
          print(e);
        });
      }).catchError((e) {
        print(e);
      }).catchError((e){
        print(e);
      });
    });
  }
}

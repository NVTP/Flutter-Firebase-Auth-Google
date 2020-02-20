import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class curdMedthods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addData(carData) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('Cars').add(carData).catchError((e){
        print(e);
      });
//      Firestore.instance.runTransaction((Transaction crudTranscation) async {
//        CollectionReference reference =
//            await Firestore.instance.collection('Cars');
//
//        reference.add(carData);
//      });
    } else {
      print('You need to Loggin');
    }
  }

  getData() async {
    return await Firestore.instance.collection('Cars').snapshots();
  }

  updateData(selectDoc, newValues) {
    Firestore.instance
        .collection('Cars')
        .document(selectDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

  deleteData(docId) {
    Firestore.instance
        .collection('Cars')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}

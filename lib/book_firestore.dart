import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookFirestore extends StatefulWidget {
  @override
  _BookFirestoreState createState() => _BookFirestoreState();
}

class _BookFirestoreState extends State<BookFirestore> {
  String name = 'Hello';
  final db = Firestore.instance;

  void createRecord() async {
     db.collection('books');
    DocumentReference ref = await db
        .collection('books')
        .add({'title': 'Flutter in Action', 'description': name});
    ref.updateData({
      'DocId': ref.documentID,
      'add': DateTime.now(),
      'time': FieldValue.serverTimestamp(), //Timestamp.now()
      'creatAt': DateTime.now().year.toString() +
          '/' +
          DateTime.now().month.toString() +
          '/' +
          DateTime.now().day.toString() +
          ' , ' +
          DateTime.now().hour.toString() +
          ':' +
          DateTime.now().minute.toString()
    }).then((val){
      ref.setData({
        'test New': Timestamp.now()
      },merge: true);
    });
    print(ref.documentID);
  }

  void getData() {
    db.collection('books').getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}'));
    });
  }

  void updateDate() {
    try {
      db
          .collection('books')
          .document('1')
          .updateData({'description': 'First Update'});
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteData() {
    try {
      db.collection('books').document('1').delete();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        title: Text('Use Cloud Firestore'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              splashColor: Colors.transparent,
              child: Text(
                'Create Record',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: createRecord,
              color: Colors.green[100],
            ),
            RaisedButton(
              splashColor: Colors.transparent,
              child: Text(
                'Get Data',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: getData,
              color: Colors.green[100],
            ),
            RaisedButton(
              splashColor: Colors.transparent,
              child: Text(
                'Update Data',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: updateDate,
              color: Colors.green[100],
            ),
            RaisedButton(
              splashColor: Colors.transparent,
              child: Text(
                'Delete Data',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: deleteData,
              color: Colors.green[100],
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:login/profile/profilepage.dart';
import 'package:login/profile/services/usermanagement.dart';

class SelectprofilepicPage extends StatefulWidget {
  @override
  _SelectprofilepicPageState createState() => _SelectprofilepicPageState();
}

class _SelectprofilepicPageState extends State<SelectprofilepicPage> {
  File newProfilePic;

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      newProfilePic = tempImage;
    });
  }

  uploadImage() async{
    var randomno = Random(25);
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('profilepics/${randomno.nextInt(5000).toString()}.jpg');
    StorageUploadTask task = firebaseStorageRef.putFile(newProfilePic);
    StorageTaskSnapshot snapshottask = await task.onComplete;
    String downloadUrl = await snapshottask.ref.getDownloadURL();
//    if(downloadUrl != null){
//      userManagement.updateProfilePic(downloadUrl.toString()).then((val){
//        Navigator.of(context).pushReplacementNamed('/homepage');
//      }).catchError((e){
//        print(e);
//      });
//    }
  }

  UserManagement userManagement = new UserManagement();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: newProfilePic == null ? getChooseButton() : getUploadButton(),
    );
  }

  Widget getChooseButton() {
    return Stack(
      children: <Widget>[
        ClipPath(
          child: Container(color: Colors.teal.withOpacity(0.8)),
          clipper: getClipper(),
        ),
        Positioned(
          width: 350.0,
          top: MediaQuery.of(context).size.height / 5,
          child: Column(
            children: <Widget>[
              Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://i.imgur.com/BoN9kdC.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(75.0)),
                  boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)],
                ),
              ),
              SizedBox(
                height: 90.0,
              ),
              Text(
                'You have signes up',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Choose a profile pic',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 75,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 30.0,
                    width: 95,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.greenAccent,
                      color: Colors.green,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: getImage,
                        child: Center(
                          child: Text(
                            'Change pic',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 95,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.blueAccent,
                      color: Colors.blue,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getUploadButton() {
    return Stack(
      children: <Widget>[
        ClipPath(
          child: Container(color: Colors.teal.withOpacity(0.8)),
          clipper: getClipper(),
        ),
        Positioned(
          width: 350.0,
          top: MediaQuery.of(context).size.height / 5,
          child: Column(
            children: <Widget>[
              Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                        image: FileImage(newProfilePic), fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.circular(75.0)),
                    boxShadow: [
                      BoxShadow(blurRadius: 7.0, color: Colors.black)
                    ]),
              ),
              SizedBox(
                height: 90.0,
              ),
              Text(
                'You have signed up',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Tap Upload to proceed',
                style: TextStyle(
                  fontSize: 17,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(
                height: 75,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 30.0,
                    width: 95.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      shadowColor: Colors.greenAccent,
                      color: Colors.green,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: uploadImage,
                        child: Center(
                          child: Text(
                            'Upload',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

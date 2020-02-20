import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/crud.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String carModel;
  String carColor;

  var car;

  curdMedthods crudObj = new curdMedthods();

  Future<bool> addDialog(BuildContext context)async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Add Data',style: TextStyle(fontSize: 15),),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration.collapsed(hintText: 'Car Name'),
                  onChanged: (value){
                    this.carModel = value;
                  },
                ),
                SizedBox(height: 5.0,),
                TextField(
                  decoration: InputDecoration.collapsed(hintText: 'Car Color'),
                  onChanged: (value){
                    this.carColor = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Add'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).pop();
                crudObj.addData({
                  'carName': this.carModel,
                  'color': this.carColor
                }).then((result) {
                  dialogTrigger(context);
                }).catchError((e) {
                  print(e);
                });
              },
            )
          ],
        );
      }
    );
  }

  @override
  void initState(){
    crudObj.getData().then((result){
     setState(() {
       car = result;
     });
    });
    super.initState();
  }

  Future<bool> updateDialog(BuildContext context,selectDoc)async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Update Data',style: TextStyle(fontSize: 15),),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration.collapsed(hintText: 'Car Name'),
                    onChanged: (value){
                      this.carModel = value;
                    },
                  ),
                  SizedBox(height: 5.0,),
                  TextField(
                    decoration: InputDecoration.collapsed(hintText: 'Car Color'),
                    onChanged: (value){
                      this.carColor = value;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Update'),
                textColor: Colors.blue,
                onPressed: (){
                  Navigator.of(context).pop();
                  crudObj.updateData(selectDoc,{
                    'carName': this.carModel,
                    'color' : this.carColor
                  }).then((result){
//                    dialogTrigger(context);
                  }).catchError((e){
                    print(e);
                  });
                },
              ),
            ],
          );
        }
    );
  }

  Future<bool> dialogTrigger(BuildContext context)async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Job Done',style: TextStyle(fontSize: 15),),
          content: Text('Added'),
          actions: <Widget>[
            FlatButton(
              child: Text('Alright'),
              textColor: Colors.blue,
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              addDialog(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              crudObj.getData().then((result){
                setState(() {
                  car = result;
                });
              });
            },
          ),
        ],
      ),
      body: Center(
        child: _carList(),
      ),
    );
  }

  Widget _carList(){
    if(car != null){
      return StreamBuilder(
        stream: car,
        builder: (context, snapshot){
          return ListView.separated(
            separatorBuilder: (context, i){
              return Divider(
                color: Colors.red,
                height: 0.0,
              );
            },
            itemCount:  snapshot.data.documents.length,
            padding: EdgeInsets.all(5.0),
            itemBuilder: (context , i){
              return ListTile(
                title: Text(snapshot.data.documents[i].data['carName']),
                subtitle: Text(snapshot.data.documents[i].data['color']),
                onTap: (){
                  updateDialog(context, snapshot.data.documents[i].documentID);
                },
                onLongPress: (){
                  crudObj.deleteData(snapshot.data.documents[i].documentID);
                },
              );
            },
          );
        },
      );
    }else{
      return Text('Loading, Please wait...');
    }
  }
}

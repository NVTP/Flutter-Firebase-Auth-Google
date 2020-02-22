import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/role/role_allusers.dart';
import 'package:login/role/services/role_usermanagement.dart';

class RoleDashboardPage extends StatefulWidget {
  @override
  _RoleDashboardPageState createState() => _RoleDashboardPageState();
}

class _RoleDashboardPageState extends State<RoleDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
      ),
      drawer: Drawer(
         child: ListView(
           children: <Widget>[
              UserAccountsDrawerHeader(
               accountName:  Text('Raja'),
               accountEmail:  Text('testemail@test.com'),
               currentAccountPicture:  CircleAvatar(
                 backgroundImage:  NetworkImage('http://i.pravatar.cc/300'),
               ),
             ),
              ListTile(
               title:  Text('Allusers Page'),
               onTap: () {
                 Navigator.of(context).pop();
                 Navigator.push(
                     context,
                      MaterialPageRoute(
                         builder: (BuildContext context) =>  RoleAllusersPage()));
               },
             ),
             ListTile(
               title:  Text('Admin Area'),
               onTap: () {
                 UserManagement().authoreizeAccess(context);
               },
             ),
             ListTile(
               title:  Text('Logout'),
               onTap: () {
                 UserManagement().signOut();
               },
             ),
           ],
         ),
      ),
      body: Center(
        child: Text('Dashboard'),
      ),
    );
  }
}

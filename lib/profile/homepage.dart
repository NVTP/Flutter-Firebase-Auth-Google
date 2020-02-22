import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:login/profile/profilepage.dart';
import 'package:login/profile/dashboard.dart';
import 'package:login/profile/chatpage.dart';
import 'package:login/profile/groups.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  TabController tabController;

  @override
  void initState(){
    super.initState();
    tabController = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new Material(
        color: Colors.teal,
        child: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.home),),
            Tab(icon: Icon(Icons.chat),),
            Tab(icon: Icon(Icons.group),),
            Tab(icon: Icon(Icons.person),),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          DashboardPage(),
          ChatPage(),
          GroupPage(),
          MyHomePage()
        ],
      ),
        );
  }
}
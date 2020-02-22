import 'package:flutter/material.dart';

class RoleAdminPage extends StatefulWidget {
  @override
  _RoleAdminPageState createState() => _RoleAdminPageState();
}

class _RoleAdminPageState extends State<RoleAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admins only'),
        centerTitle: true,
      ),
    );
  }
}

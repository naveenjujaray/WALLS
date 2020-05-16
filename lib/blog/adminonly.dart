import 'package:Walls/bloc/navigation_bloc/dashboard_navigation.dart';
import 'package:Walls/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:Walls/blog/maindrawer.dart';
import 'package:Walls/pages/nav.dart';
import 'package:Walls/pages/widget.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget with NavigationStates,DashboardStates{
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Admin Only'),
        elevation: 0.0,
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Admin Page'),
          ],
        ),
      ),
    );
  }
}

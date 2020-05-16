import 'package:Walls/bloc/navigation_bloc/dashboard_navigation.dart';
import 'package:Walls/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:Walls/pages/widget.dart';
import 'package:flutter/material.dart';


class UserPage extends StatefulWidget with NavigationStates,DashboardStates{
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
    );
  }
}

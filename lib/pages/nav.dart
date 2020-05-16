
import 'package:Walls/pages/homepage.dart';
import 'package:Walls/pages/splash_screen.dart';
import 'package:Walls/sidebar/sidebar_layout.dart';

import 'package:flutter/material.dart';

class MyNavigator {

   static void goToHome(BuildContext context) {
     Navigator.pushAndRemoveUntil(
       context,
       MaterialPageRoute(builder: (context) => SideBarLayout()),
           (Route<dynamic> route) => false,
     );

  }



}
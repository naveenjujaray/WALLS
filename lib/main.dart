
import 'package:Walls/blog/blogpage.dart';
import 'package:Walls/pages/aboutpage.dart';
import 'package:Walls/pages/homepage.dart';
import 'package:Walls/pages/nav.dart';
import 'package:Walls/sidebar/sidebar_layout.dart';
import 'package:flutter/material.dart';

import 'package:Walls/pages/splash_screen.dart';

import 'blog/adminonly.dart';
import 'blog/loginpage.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomePage(),
};

void main() => runApp(new MaterialApp(
    theme:
    ThemeData(primaryColor: Colors.black, accentColor: Colors.cyan),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: <String, WidgetBuilder> {
      '/adminpage': (BuildContext context) =>  AdminPage(),
      '/homepage': (BuildContext context) =>  SideBarLayout(),
      '/blogpage': (BuildContext context) =>  BlogPage(),
      '/aboutpage': (BuildContext context) =>  AboutPage(),
      '/logout': (BuildContext context) => LoginPage(),
    },
));

import 'package:Walls/pages/homepage.dart';
import 'package:flutter/material.dart';

import 'package:Walls/pages/splash_screen.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomePage(),
};

void main() => runApp(new MaterialApp(
    theme:
    ThemeData(primaryColor: Colors.black, accentColor: Colors.cyan),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: routes));
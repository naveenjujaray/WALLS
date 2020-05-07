import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:Walls/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:Walls/commons/rounded_image.dart';
import 'package:Walls/pages/homepage.dart';
import 'package:Walls/sidebar/menu_item.dart';
class SideBar extends StatefulWidget {

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin{
  AnimationController _animationController ;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;

  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }
void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if(isAnimationCompleted)
      {
        isSidebarOpenedSink.add(false);
        _animationController.reverse();
      }
    else
      {
        isSidebarOpenedSink.add(true);
        _animationController.forward();
      }
}
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSidebarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSidebarOpenedAsync.data ? 0 : - screenWidth,
          right: isSidebarOpenedAsync.data ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(child: Container(
                color: Colors.black,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 100,),
                    ListTile(
                      title: Text("Walls", style: TextStyle(
                        color: Colors.white,
                        fontSize: 30, fontWeight: FontWeight.w800)),
                      subtitle: Text("by Naveen Jujaray", style: TextStyle(
                          color: Color(0xFF1BB5FD), fontSize: 20,
                      ),),
                      leading:
                        Image.asset(
                          "assets/icons/w.png",
                        ),
                    ),
                    Divider(
                      height: 64,
                      thickness: 0.5,
                      color: Colors.white.withOpacity(0.3),
                      indent: 32,
                      endIndent: 32,
                    ),
                    MenuItem(
                      icon: Icons.home,
                      title: "Home",
                      onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageCickedEvent);
                      },
                    ), //home
                   // MenuItem(
                     // icon: Icons.settings,
                      // title: "Settings",
                      // onTap: () {
                        // onIconPressed();
                        // BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.SettingsPageClickedEvent);
                      // },
                    // ),//Settings
                    MenuItem(
                      icon: Icons.person,
                      title: "About Me",
                      onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.AboutPageClickedEvent);
                      },
                    ),//About Me
                  ],
                ),

              ),),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Colors.black,
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: _animationController.view,
                        color: Colors.white ,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        );
      },

    );
  }
}
class CustomMenuClipper extends CustomClipper<Path> {
  @override
   Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width-1, height/2 - 20, width, height/2);
    path.quadraticBezierTo(width+1, height/2 + 20, 10, height-16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }

}

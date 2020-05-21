import 'dart:io';
import 'package:Walls/rating/smiley_painter.dart';
import 'package:Walls/blog/services/usermanagement.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:Walls/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:Walls/commons/rounded_image.dart';
import 'package:Walls/pages/homepage.dart';
import 'package:Walls/sidebar/menu_item.dart';
import 'package:rate_my_app/rate_my_app.dart';
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
                        BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickedEvent);
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
                      icon: Icons.library_books,
                      title: "Feedback",
                      onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.BlogPageClickedEvent);
                      },
                    ),//About Me
                   // MenuItem(
                     // icon: Icons.vpn_key,
                      //title: "Login",
                      //onTap: () {
                        //onIconPressed();
                        //BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.LoginPageClickedEvent);
                      //},
                    //),//About Me
                    MenuItem(
                      icon: Icons.star,
                      title: "Rate",
                      onTap: () {
                        onIconPressed();
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) => SmileyRatingDialog(
                              title: Text('Rate Walls',style: TextStyle(color: Colors.white),),
                              starColor: Colors.yellow,
                              isRoundedButtons: true,
                              positiveButtonText: 'Ok',
                              negativeButtonText: 'Cancel',
                              positiveButtonColor: Colors.blueAccent,
                              negativeButtonColor: Colors.grey,
                              onCancelPressed: () => Navigator.pop(context),
                              onSubmitPressed: (rating) {},
                            ));
                      },
                    ),

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

class SmileyRatingDialog extends StatefulWidget{

  // Color of star buttons
  final Color starColor;

  // Called when positive button is clicked
  final ValueSetter<int> onSubmitPressed;

  // Called when negative button is clicked
  final VoidCallback onCancelPressed;

  // Text of Positive Button
  final String positiveButtonText;

  // Text of Positive Button
  final String negativeButtonText;

  // Color of Positive Button
  final Color positiveButtonColor;

  // Color of Positive Button
  final Color negativeButtonColor;

  // Title of Dialog
  final Widget title;

  // Whether the corners of the buttons should be rounded or not
  final bool isRoundedButtons;

  SmileyRatingDialog(
      {this.starColor = Colors.yellow,
        this.title,
        @required this.onSubmitPressed,
        @required this.onCancelPressed,
        @required this.positiveButtonText,
        @required this.negativeButtonText,
        this.isRoundedButtons = true,
        this.positiveButtonColor = Colors.amber,
        this.negativeButtonColor = Colors.amber});

  @override
  _SmileyRatingDialogState createState() => _SmileyRatingDialogState();
}

class _SmileyRatingDialogState extends State<SmileyRatingDialog> {
  int _rating = 0;

  List<Widget> _starWidgets() {
    List<Widget> buttons = [];

    for (int rateValue = 1; rateValue <= 5; rateValue++) {
      final starRatingButton = IconButton(
          icon: Icon(_rating >= rateValue ? Icons.star : Icons.star_border,
              color: widget.starColor, size: 35),
          onPressed: () {
            setState(() {
              _rating = rateValue;
            });
          });
      buttons.add(starRatingButton);
    }

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: widget.title,
      contentPadding: EdgeInsets.all(20.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            child: CustomPaint(
              painter: SmileyPainter(rating: _rating),
            ),
          ),
          Row(children: _starWidgets()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        widget.isRoundedButtons ? 4.0 : 0.0)),
                color: widget.positiveButtonColor,
                onPressed: () {
                  widget.onSubmitPressed(_rating);
                },
                child: Text(widget.positiveButtonText),
              ),
              FlatButton(
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        widget.isRoundedButtons ? 4.0 : 0.0)),
                color: widget.negativeButtonColor,
                onPressed: () {
                  widget.onCancelPressed();
                },
                child: Text(widget.negativeButtonText),
              ),
            ],
          )
        ],
      ),
    );
  }
}
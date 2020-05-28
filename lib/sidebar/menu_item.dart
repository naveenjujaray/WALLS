
import 'package:Walls/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuItem extends StatelessWidget with NavigationStates{
  final IconData icon;
  final String title;
  final onTap;

  const MenuItem({Key key, this.icon, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
        child: Padding(
        padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
              Icon(

              icon,
              color: Colors.cyan,
              size: 30,
              ),
                SizedBox(width: 20,),
                Text(title, style: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 26, color: Colors.white
          ),)
        ],
      ),
         ),
    );
  }
}

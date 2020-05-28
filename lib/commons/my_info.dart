import 'package:Walls/commons/radial_progress.dart';
import 'package:Walls/commons/rounded_image.dart';
import 'package:Walls/styleguide/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
            child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RadialProgress(
            width: 5,
            goalCompleted: 1.0,
            child: RoundedImage(
              imagePath: "assets/images/annie.jpg",
              size: Size.fromWidth(120.0),
            ),
          ),
                   SizedBox(height: 10,),
                  Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                        Text(
                "Naveen Jujaray",
                style: whiteNameTextStyle,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Flutter Developer",
              style: whiteSubHeadingTextStyle,
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/icons/location_pin.png",
                width: 20.0,
                color: Colors.white,
              ),
              Text(
                "  Hyderabad, India",
                style: whiteSubHeadingTextStyle,
              )
            ],
          )
        ],
      ),
      );
  }
}
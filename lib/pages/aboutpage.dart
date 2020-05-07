import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Walls/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:Walls/commons/my_info.dart';
import 'package:Walls/commons/opaque_image.dart';
import 'package:Walls/styleguide/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Walls/styleguide/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AboutPage extends StatelessWidget with NavigationStates{
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Stack(
                  children: <Widget>[
                    OpaqueImage(
                      imageUrl: "assets/images/annie.png",
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "About Me",
                                textAlign: TextAlign.center,
                                style: headingTextStyle,
                              ),
                            ),
                            MyInfo(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,

                child: SingleChildScrollView(

                  child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                          color: Colors.grey.shade200,
                      ),
                      child: Text("These images are gathered from Pexels, Walls was developed using Flutter in Android Studio. "
                      "Source code is available in Github.",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                    ),
                  ],
                ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                child: Row(
                  children: <Widget>[
                    _buildSocialsRow(),
                    SizedBox(height: 20.0,),
                  ],
                ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title.toUpperCase(), style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold
          ),),
          Divider(color: Colors.black54,),
        ],
      ),
    );
  }
  Row _buildSocialsRow() {
    return Row(
      children: <Widget>[
        SizedBox(width: 20.0),
        IconButton(
          color: Colors.black,
          icon: Icon(FontAwesomeIcons.facebookF),
          onPressed: (){
            _launchURL("https://facebook.com/naveenjujaray");
          },
        ),
        SizedBox(width: 5.0),
        IconButton(
          color: Colors.black,
          icon: Icon(FontAwesomeIcons.github),
          onPressed: (){
            _launchURL("https://github.com/naveenjujaray");
          },
        ),
        SizedBox(width: 5.0),
        IconButton(
          color: Colors.black,
          icon: Icon(FontAwesomeIcons.linkedin),
          onPressed: (){
            _launchURL("https://www.linkedin.com/in/naveen-jujaray-b5776456/");
          },
        ),
        SizedBox(width: 10.0),
      ],
    );
  }



}
import 'package:Walls/pages/homepage.dart';
import 'package:Walls/sidebar/menu_item.dart';
import 'package:flutter/material.dart';
class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.black,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width:100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 10,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        'assets/images/annie.jpg',
                        width: 110.0,
                        height: 110.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text('Name',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w900),),
                  Text('Email Address',style: TextStyle(color: Colors.white,fontSize: 16),),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home,color: Colors.cyan,),
            title: Text('Home',style: TextStyle(color: Colors.black,fontSize: 18),),
            onTap: (){
              Navigator.pushReplacementNamed(context,'/homepage');
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books,color: Colors.cyan,),
            title: Text('Blog',style: TextStyle(color: Colors.black,fontSize: 18),),
            onTap: (){
              Navigator.pushReplacementNamed(context,'/blogpage');
            },
          ),
          ListTile(
            leading: Icon(Icons.person,color: Colors.cyan,),
            title: Text('About Me',style: TextStyle(color: Colors.black,fontSize: 18),),
            onTap: (){
              Navigator.pushReplacementNamed(context,'/aboutpage');
            },
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new,color: Colors.cyan,),
            title: Text('Logout',style: TextStyle(color: Colors.black,fontSize: 18),),
            onTap: null,
          ),
        ],
      )
    );
  }
}

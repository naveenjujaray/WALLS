import 'package:Walls/bloc/navigation_bloc/dashboard_navigation.dart';
import 'package:Walls/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:Walls/blog/adminonly.dart';
import 'package:Walls/blog/loginpage.dart';
import 'package:Walls/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:Walls/blog/loginpage.dart';



class UserManagement with DashboardStates,NavigationStates{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Widget handleAuth(){
    return new StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {

        if(snapshot.hasData)
        {
          return AdminPage();
        }
        else {
          return LoginPage();
        }

      }
    );
  }

  authorizeAcess(BuildContext context){
    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance
          .collection('/users')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
         if(docs.documents[0].exists){
           if(docs.documents[0].data['role'] = ('admin') == null) {
             Navigator.of(context).push(
                  new MaterialPageRoute(
                 builder: (BuildContext context) => AdminPage(),
                 )
             );
           }
           else{
             print('Not Authorized');
           }
         }
      });
    });
  }

signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      return LoginPage();
    }
  }
}
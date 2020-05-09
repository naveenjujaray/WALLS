import 'package:Walls/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:Walls/blog/services/usermanagement.dart';
import 'package:Walls/pages/widget.dart';
import 'package:Walls/styleguide/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget with NavigationStates{
  @override



  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
        body: Center(
          child: Container(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(

                      decoration: InputDecoration(
                          hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.mail,
                        color: Colors.white,),
                        fillColor: Colors.white.withOpacity(0.2),
                        filled: true,
                        border: new OutlineInputBorder(

                          borderRadius: const BorderRadius.all(

                            const Radius.circular(20),
                          ),
                          borderSide: new BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });

                      },
                    cursorColor: Colors.white,
                    style: (TextStyle(color: Colors.white)),
                      ),
                  SizedBox(height: 15.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.lock,
                      color: Colors.white),
                      fillColor: Colors.white.withOpacity(0.2),
                      filled: true,
                      border: new OutlineInputBorder(

                        borderRadius: const BorderRadius.all(

                          const Radius.circular(20),
                        ),
                        borderSide: new BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {

                        _password = value;
                      });
                    },
                    obscureText: true,
                    cursorColor: Colors.white,
                    style: (TextStyle(color: Colors.white)),

                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    padding: EdgeInsets.only(left: 50.0, right: 50.0),
                    child: Text('Login'),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 7.0,
                    onPressed: () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                          email: _email.trim(), password: _password)
                          .then((signedInUser) {
                        Navigator.of(context).pushReplacementNamed('/adminpage');
                      }).catchError((e) {
                        print(e);
                      });
                    },
                  ),
                  SizedBox(height: 15.0),
                  Text("You're trying to authorize admin area", style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.blueAccent),),
                  SizedBox(height: 10.0),
          ]
                  ),

              )),
        );

  }
}

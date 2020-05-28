import 'dart:convert';
import 'package:Walls/commons/data.dart';
import 'package:Walls/pages/widget.dart';
import 'package:http/http.dart' as http;
import 'package:Walls/commons/wallpaper_model.dart';
import 'package:flutter/material.dart';
import 'package:wiredash/wiredash.dart';
class Categorie extends StatefulWidget {
  final String categoryName;
  Categorie({this.categoryName});
  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {

  List<WallpaperModel> wallpapers = new List();

  getSearchWallpapers(String query) async{
    var response = await http.get("https://api.pexels.com/v1/search?query=$query&per_page=15&page=1",
        headers: {
          "Authorization" : apikey
        }
    );
    //print(response.body.toString());

    Map<String,dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element){
      //print(element);
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {

    });
  }
  @override
  void initState() {
    getSearchWallpapers(widget.categoryName);
    super.initState();
  }
  int _counter = 0;
  void _incrementCounter(){
    setState(() {
      _counter++;
    });
    Wiredash.of(context).show();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: brandName(),
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: _incrementCounter,
        child: Icon(Icons.feedback,
          color: Colors.white,),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[

              SizedBox(height: 16,),
              WallpapersList(wallpapers: wallpapers,context: context)
            ],
          ),
        ),
      ),
    );
  }
}

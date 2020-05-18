import 'dart:convert';

import 'package:Walls/commons/data.dart';
import 'package:Walls/commons/wallpaper_model.dart';
import 'package:flutter/material.dart';
import 'package:Walls/pages/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {

  final String searchQuery;
  Search({this.searchQuery});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  List<WallpaperModel> wallpapers = new List();
  TextEditingController searchController = new TextEditingController();

  getSearchWallpapers(String query) async{
    var response = await http.get("https://api.pexels.com/v1/search?query=$query&per_page=80&page=1",
        headers: {
          "Authorization" : apikey
        }
    );
    //print(response.body.toString());

    Map<String,dynamic> jsonData = jsonDecode(response.body);
    wallpapers = new List();
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
    getSearchWallpapers(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(

                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(

                        controller: searchController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: ("Search Walls"),
                          border: InputBorder.none,
                        ),
                        style: (TextStyle(color: Colors.white)),
                      ),

                    ),
                    GestureDetector(
                      onTap: (){
                        getSearchWallpapers(searchController.text);
                      },
                      child: Container(
                          child: Icon(Icons.search,color: Colors.white,)),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16,),
              WallpapersList(wallpapers: wallpapers,context: context)
            ],
          ),
        ),
      ),
    );
  }
}

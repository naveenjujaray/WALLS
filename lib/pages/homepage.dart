import 'dart:convert';
import 'package:Walls/commons/category_model.dart';
import 'package:Walls/commons/data.dart';
import 'package:Walls/commons/image_view.dart';
import 'package:Walls/commons/wallpaper_model.dart';
import 'package:flutter/src/foundation/annotations.dart';
import 'package:flutter/material.dart';
import 'package:Walls/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:Walls/pages/widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:Walls/pages/search.dart';
import 'package:Walls/pages/category.dart';
class HomePage extends StatefulWidget with NavigationStates {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<CategoryModel> category = new List();
  List<WallpaperModel> wallpapers = new List();
  TextEditingController searchController = new TextEditingController();
  getTrendingWallpapers() async{
    var response = await http.get("https://api.pexels.com/v1/curated?per_page=500&page=1",
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
    getTrendingWallpapers();
    category = getCategory();
    super.initState();
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
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30)
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Search Walls",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Search(
                            searchQuery: searchController.text,
                          )
                        ));

                      },
                      child: Container(
                          child: Icon(Icons.search)),
                    )
                  ],
                ),
              ),

              SizedBox(height: 16,),
              Container(
                height: 80,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  itemCount: category.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){

                    return CategoryTile(
                      title: category[index].categoriesName,
                      imgUrl: category[index].imgUrl,
                    );
                }),
              ),
              WallpapersList(wallpapers: wallpapers,context: context)
            ],
          ),
        ),
      ),
    );
  }
}
class CategoryTile extends StatelessWidget {
  final String imgUrl, title;
  CategoryTile({@required this.title, @required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Categorie(
            categoryName:title.toLowerCase()
          )
        )
        );
      },
      child: Container(
          margin: EdgeInsets.only(right: 4),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                    child: Image.network(imgUrl, height: 50, width: 100,fit: BoxFit.cover,)),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(16),
                ),

                height: 50, width: 100,
                alignment: Alignment.center,
                child: (Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15 ),)
                ),
              ),
            ],
          ),
        ),
    );

  }
}


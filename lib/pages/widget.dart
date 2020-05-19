import 'package:Walls/commons/image_view.dart';
import 'package:Walls/commons/wallpaper_model.dart';
import 'package:flutter/material.dart';

Widget brandName() {
  return
      RichText(
      text: TextSpan(
        style:TextStyle(fontSize: 20),
        children: <TextSpan>[
          TextSpan(text: 'W', style: TextStyle(fontSize: 24,color: Colors.cyan,fontWeight: FontWeight.w900,)),
          TextSpan(text: 'alls'),
        ],
      ),
    );

}

Widget WallpapersList({List<WallpaperModel> wallpapers, context }){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper){
        return GridTile(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ImageView(
                    imgUrl: wallpaper.src.portrait,
                  )
              ));
            },
            child: Hero(
                tag: wallpaper.src.portrait,
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(wallpaper.src.portrait,fit: BoxFit.cover,)),
              ),
            ),
          ),
        );
      }
      ).toList(),
    ),
  );
}
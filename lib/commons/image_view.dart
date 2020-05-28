import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper/wallpaper.dart';

class ImageView extends StatefulWidget {


  final String imgUrl;

  ImageView({@required this.imgUrl});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  var imgPath;

  String home = "Home Screen",
      lock = "Lock Screen",
      both = "Both Screen",
      system = "System";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgUrl,
            child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Image.network(
                  widget.imgUrl,
                  fit: BoxFit.cover,
                )),
          ),
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  splashColor: Colors.green,
                  hoverElevation: 10,
                  color: Colors.black.withOpacity(0.2),
                  colorBrightness: Brightness.dark,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(60.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  padding: EdgeInsets.all(10.0),
                  onPressed: () {
                    _modal();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Set as Wallpaper", style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20),),
                    ],
                  ),

                ),
                SizedBox(height: 0,),
                RaisedButton(
                  splashColor: Colors.redAccent,
                  hoverElevation: 10,
                  color: Colors.black.withOpacity(0.2),
                  colorBrightness: Brightness.dark,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(60.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  padding: EdgeInsets.all(5.0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Cancel", style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 15),),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // _save() async {
  // if (Platform.isAndroid) {
  //  await _askPermission();
  //}
  // var response = await Dio()
  //    .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
  //final result =
  //await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
  // home = await Wallpaper.homeScreen(widget.imgUrl);
  // final result = home = home;
  // print(result);
  // }

  _askPermission() async {
    if (Platform.isAndroid) {
      /*Map<PermissionGroup, PermissionStatus> permissions =
          */
      await PermissionHandler().requestPermissions([
        PermissionGroup.storage,
        PermissionGroup.camera,
        PermissionGroup.location,
      ]);
    } else {
      /* PermissionStatus permission = */ await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
    }
  }

  _modal() {
    showModalBottomSheet(

        backgroundColor: Colors.white.withOpacity(0.2),
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30,)),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 130,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )
            ),

            child: Column(

              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _createTile(context, 'Home Screen', Icons.home, _action1),
                SizedBox(height: 10,),
                _createTile(context, 'Lock Screen', Icons.lock, _action2),
              ],
            ),
          );
        }
    );
  }

  ListTile _createTile(BuildContext context, String name, IconData icon,
      Function action) {
    return ListTile(
      leading: Icon(icon,
        color: Colors.blueAccent,),
      title: Text(name,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),),
      onTap: () {
        Navigator.pop(context);
        action();
      },
    );
  }

  _action1() async {
    if (Platform.isAndroid) {
      await _askPermission();
    }
    var response = await Dio()
        .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
    //await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    home = await Wallpaper.homeScreen(widget.imgUrl);
    final result = home = home;
    print(result);
  }

  _action2() async {
    if (Platform.isAndroid) {
      await _askPermission();
    }
    var response = await Dio()
        .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
    //await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    home = await Wallpaper.lockScreen(widget.imgUrl);
    final result = home = lock;
    print(result);
  }


}






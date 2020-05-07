
import 'package:Walls/styleguide/colors.dart';
import 'package:flutter/material.dart';

class OpaqueImage extends StatelessWidget {

  final imageUrl;

  const OpaqueImage({Key key, @required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
         children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}
class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = new Path();

    double x = size.width;
    double y = size.height;
    path.lineTo(0.0, y-40.0);
    //var controllPoint = Offset(50, size.height);
    //var endPoint = Offset(size.width/2, size.height);
    path.quadraticBezierTo(x/2.0,y,x,y-40.0);//controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    //path.lineTo(size.width, size.height);
    //path.lineTo(size.width, 0);
    path.lineTo(x, 0.0);

    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

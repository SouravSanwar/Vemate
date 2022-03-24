import 'package:flutter/material.dart';

class Vault extends StatelessWidget implements PreferredSizeWidget {
  final Text? title;
  final double? barHeight = 50.0;
  Vault({ this.title}) ;
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight );
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        child: ClipPath(
          clipper: WaveClip(),
          child: Container(
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight ));
  }
}
class WaveClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0.0, size.height*.2);
    var startpoints= Offset(size.width *0.5, size.height*0.2);
    var startcontrolpoints= Offset(size.width* 0.25, size.height*0.25);
    path.quadraticBezierTo(startcontrolpoints.dx, startcontrolpoints.dy,
                            startpoints.dx, startpoints.dy);
    var endpoints=Offset(size.width, size.height*0.2-80.0);
    var endcontrolpoints=Offset(size.width*0.75, size.height*0.2);

    path.quadraticBezierTo(endcontrolpoints.dx, endcontrolpoints.dy,
                                    endpoints.dx, endpoints.dy);

    path.lineTo(size.width, 0.0);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
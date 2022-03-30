import 'package:flutter/material.dart';

class WaveClip extends CustomClipper<Path> {
  late final double? adjust = -5;
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0.0, size.height * 0.60-10 );

    var startpoints = Offset(size.width * 0.273, size.height * 0.819 - adjust!);
    var startcontrolpoints =
    Offset(size.width * 0.166, size.height * 0.84 - adjust!);
    path.quadraticBezierTo(startcontrolpoints.dx, startcontrolpoints.dy,
        startpoints.dx, startpoints.dy);

    var midpoints = Offset(size.width * 0.6666, size.height * 0.790 - adjust!);
    var midcontrolpoints =
    Offset(size.width * 0.5, size.height * 0.80 - adjust!);

    path.quadraticBezierTo(
        midcontrolpoints.dx, midcontrolpoints.dy, midpoints.dx, midpoints.dy);

    var endpoints = Offset(size.width*1.5, size.height*1.5);
    var endcontrolpoints =
    Offset(size.width * 0.93, size.height * 0.79 - adjust!);

    path.quadraticBezierTo(
        endcontrolpoints.dx, endcontrolpoints.dy, endpoints.dx, endpoints.dy);

    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

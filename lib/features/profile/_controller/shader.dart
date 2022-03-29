import 'package:flutter/cupertino.dart';

class Shader extends StatelessWidget{
  final Icon? icon;
  Shader({
    this.icon
  });
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            colors: [
              Color(0xff8760EE),
              Color(0xffA984E5),
              Color(0xffCA88E8),
            ],
            tileMode: TileMode.repeated,
          ).createShader(bounds);
        },

        child: icon
    );
  }
}
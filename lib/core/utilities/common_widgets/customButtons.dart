import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';

class CustomButtons extends StatelessWidget {

  double? height;
  double? width;
  VoidCallback? onTap;
  String? text;
  TextStyle? style;

  CustomButtons({
    this.height,
    this.width,
    this.onTap,
    this.text,
    this.style,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: AppColors.purpleGradient, // set border width
        borderRadius: const BorderRadius.all(
            Radius.circular(25.0)), // set rounded corner radius
      ),
      child: InkWell(
        onTap: onTap,


        child: Text(text!,style: style,),
      ),
    );
  }
}


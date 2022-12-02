import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';

class CustomButtons extends StatelessWidget {
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final String? text;
  final TextStyle? style;
  double? borderRadius;

  CustomButtons({
    Key? key,
    this.height,
    this.width,
    this.onTap,
    this.text,
    this.style,
    this.borderRadius=25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: AppColors.onBoardBtnGradient,
          borderRadius:  BorderRadius.all(
            Radius.circular(borderRadius!),
          ),
        ),
        child: Text(
          text!,
          style: style,
        ),
      ),
    );
  }
}

import 'package:another_flushbar/flushbar.dart';
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

  const CustomButtons({
    Key? key,
    this.height,
    this.width,
    this.onTap,
    this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: AppColors.purpleGradient,
          borderRadius: const BorderRadius.all(
            Radius.circular(25.0),
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

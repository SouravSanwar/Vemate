import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';

class DesignHelper extends StatefulWidget {
  final Widget child;
  final GestureTapCallback onPressed;

  DesignHelper({required this.onPressed, required this.child});

  @override
  _DesignHelperState createState() => _DesignHelperState();
}

class _DesignHelperState extends State<DesignHelper> {


  @override
  void initState() {
    _color = Colors.green;
    super.initState();
  }

  late Color _color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width*.2,
        height: Get.height*.05,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: AppColors.purpleGradient, // set border width
          borderRadius: const BorderRadius.all(
              Radius.circular(20.0)), // set rounded corner radius
        ),
      child: MaterialButton(
      child: widget.child,

      onPressed: () {
        widget.onPressed();
      },

    )
    );
  }
}







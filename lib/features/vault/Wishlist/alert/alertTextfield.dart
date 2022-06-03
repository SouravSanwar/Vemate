import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utilities/app_colors/app_colors.dart';

class AlertTextField extends StatelessWidget {

  TextEditingController? controller;
  num? height;//user location
  num? width;//user location

  AlertTextField({
    this.controller,
    this.height,
    this.width
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: AppColors.textColor, // set border color
            width: 1),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: TextFormField(

        controller: controller,
        cursorColor: AppColors.textColor,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}



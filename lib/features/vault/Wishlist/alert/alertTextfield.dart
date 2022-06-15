import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            width: 1.w),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: TextFormField(

        style: TextStyle(
          color: AppColors.textColor,
          fontSize: 18.0.sp,

        ),
        textAlign: TextAlign.center,
        controller: controller,
        cursorColor: AppColors.textColor,
        decoration: const InputDecoration(
          border: InputBorder.none,

        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}



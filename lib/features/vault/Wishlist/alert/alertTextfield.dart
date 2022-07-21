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
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: TextField(

          style: TextStyle(
            color: AppColors.textColor,
            fontFamily: 'Inter',
            fontSize: 16.0.sp,

          ),
          textAlign: TextAlign.left,
          controller: controller,
          cursorColor: AppColors.grey,
          decoration: const InputDecoration(
            border: InputBorder.none,

          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}



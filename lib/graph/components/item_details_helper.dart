import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/utilities/app_colors/app_colors.dart';

class ItemDetailsHelper extends StatelessWidget {
  final String? text;
  final String? text1;
  final bool? fromVault;

  ItemDetailsHelper({
    this.text,
    this.text1,
    this.fromVault = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: AppColors.graphCard),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
                child: Text(
                  text!,
                  style: TextStyle(
                      color: AppColors.detailsTextColor,
                      //fontFamily: 'Inter',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 12)),
          ),
          Expanded(
            flex: 5,
            child: Container(
                child: Text(
                  text1!,
                  style: TextStyle(
                      color: AppColors.detailsTextColor1,
                      //fontFamily: 'Inter',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2)),
          ),
          Expanded(
            flex: 2,
            child: Container(
                child: fromVault == true
                    ? const Icon(
                        Icons.edit,
                        color: Colors.deepOrangeAccent,
                      )
                    : null,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2)),
          ),
        ],
      ),
    );
  }
}

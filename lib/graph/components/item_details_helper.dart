import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/utilities/app_colors/app_colors.dart';

class ItemDetailsHelper extends StatelessWidget {
  final String? text;
  final String? text1;
  final bool? fromVault;
  final bool? topRadius;
  final bool? bottomRadius;
  final VoidCallback? onTap;


  ItemDetailsHelper({
    this.text,
    this.text1,
    this.fromVault = false,
    this.topRadius = false,
    this.bottomRadius = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topRadius==true ? 15.0:0.0),
        topRight: Radius.circular(topRadius==true ? 15.0:0.0),
        bottomLeft: Radius.circular(bottomRadius==true ? 15.0:0.0),
        bottomRight: Radius.circular(bottomRadius==true ? 15.0:0.0),
      ), color: AppColors.graphCard),
      child: Row(
        children: [
          Expanded(
            flex: 6,
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
            child:fromVault == true
                ? InkWell(
              onTap: onTap,
                  child: Container(
                  child: Icon(
                          Icons.edit,
                          color: Colors
                              .grey
                              .withOpacity(
                              .5),
                        ),
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2)),
                )
               : Container(),
          ),
        ],
      ),
    );
  }
}

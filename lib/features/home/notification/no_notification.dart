import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';

class NoNotification extends StatefulWidget {
  String? title;
   NoNotification({Key? key,this.title}) : super(key: key);

  @override
  State<NoNotification> createState() => _NoNotificationState();
}

class _NoNotificationState extends State<NoNotification> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
    body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/media/image/empty_box.png',
              height: 100.h,
              width: 100.w,
            ),
            Text(
              widget.title!,
              style: Get.textTheme.bodyMedium!.copyWith(
                fontSize: 14.0.sp,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

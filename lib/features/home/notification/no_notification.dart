import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/models/Test.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';

import '../../../core/models/NewsModel.dart';

class NoNotification extends StatefulWidget {
  const NoNotification({Key? key}) : super(key: key);

  @override
  State<NoNotification> createState() => _NoNotificationState();
}

class _NoNotificationState extends State<NoNotification> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 1.0,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: AppColors.backgroundColor,
        title: const Text(""),
      ),
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
              "No notification to show",
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

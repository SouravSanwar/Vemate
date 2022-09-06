import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/utilities/app_colors/app_colors.dart';

class NoGraphCard extends StatefulWidget {
  final String? title;

  const NoGraphCard({Key? key, this.title}) : super(key: key);

  @override
  State<NoGraphCard> createState() => _NoGraphCardState();
}

class _NoGraphCardState extends State<NoGraphCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.graphCard,
          // borderRadius: BorderRadius.circular(12.0),
          // border: Border.all(color: const Color(0xff454F70))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/media/image/empty_box.png',
              height: 100.h,
              width: 100.w,
            ),
            Text(
              widget.title.toString(),
              style: Get.textTheme.bodyMedium!.copyWith(
                fontSize: 16.0.sp,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

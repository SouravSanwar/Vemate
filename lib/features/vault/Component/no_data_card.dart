import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/utilities/app_colors/app_colors.dart';

class NoDataCard extends StatefulWidget {
  final String? title;
  const NoDataCard({Key? key, this.title}) : super(key: key);

  @override
  State<NoDataCard> createState() => _NoDataCardState();
}

class _NoDataCardState extends State<NoDataCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
    width: Get.width,
    decoration: BoxDecoration(
    gradient: AppColors.cardGradient,
    borderRadius: BorderRadius.circular(12.0),
    border: Border.all(color: const Color(0xff454F70))
    ),
      child: Column(
        children: [
          Image.asset(
            'assets/media/image/empty_box.png',
            height: 100.h,
            width: 100.w,
          ),
          Text(
            widget.title.toString(),
            style: Get.textTheme.bodyMedium!.copyWith(
              fontSize: 14.0.sp,
            ),
          ),
        ],
      ),
    ),
    );
  }
}

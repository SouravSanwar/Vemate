import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NoDataCard extends StatefulWidget {
  final String? title;
  const NoDataCard({Key? key, this.title}) : super(key: key);

  @override
  State<NoDataCard> createState() => _NoDataCardState();
}

class _NoDataCardState extends State<NoDataCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      child: Column(
        children: [
          Image.asset(
            'assets/media/image/empty-box.png',
            height: 75.h,
            width: 75.w,
          ),
          Text(
            widget.title.toString(),
            style: Get.textTheme.bodyMedium!.copyWith(
              fontSize: 14.0.sp,
            ),
          ),
        ],
      ),
    );
  }
}

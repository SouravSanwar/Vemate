import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';

import 'package:ketemaa/core/utilities/shimmer/progress_bar.dart';

class ResponseMessage extends StatelessWidget {
  final String? message;
  final IconData? icon;
  final Color? color;

  const ResponseMessage({Key? key, this.message, this.icon, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width * .9,
        height: Get.width * .75,
        alignment: Alignment.center,
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: AppColors.graphCard.withOpacity(.8),
          key: key,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              const SizedBox(height: 10),
              AutoSizeText(
                message!,
                style: TextStyle(
                  color: AppColors.textColor,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}

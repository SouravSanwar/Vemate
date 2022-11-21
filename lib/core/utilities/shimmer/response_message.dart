import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';

import 'package:ketemaa/features/profile/_controller/shader.dart';

class ResponseMessage extends StatelessWidget {
  final String? message;
  final IconData? icon;
  final Color? color;

  const ResponseMessage({Key? key, this.message, this.icon, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * .9,
      height: Get.width * .9,
      alignment: Alignment.center,
      child: AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppColors.graphCard.withOpacity(.8),
        key: key,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          Shader(
                           icon: Icon(
                             icon,
                             color: color,
                             size: 30,
                           ),
             ),

            const SizedBox(height: 10),
            AutoSizeText(
              message!,
              style: TextStyle(
                color: AppColors.textColor.withOpacity(.6),
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

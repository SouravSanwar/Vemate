import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/shimmer/progress_bar.dart';

class NoInternetDialogue extends StatelessWidget {

  const NoInternetDialogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width,
        height: Get.height*.05,
        alignment: Alignment.center,
        child: AlertDialog(
          backgroundColor: AppColors.graphCard.withOpacity(.3),
          key: key,
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              circularProgress(),
              const SizedBox(
                height: 10,
              ),
              AutoSizeText(
                "No Internet Connection",
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

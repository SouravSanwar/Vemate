import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/shimmer/color_loader.dart';

import 'package:ketemaa/core/utilities/shimmer/progress_bar.dart';

class LoadingDialogue extends StatelessWidget {
  final String? message;

  const LoadingDialogue({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width * .9,
        height: Get.width * .8,
        alignment: Alignment.center,
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          key: key,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ColorLoader(),
              const SizedBox(
                height: 10,
              ),
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

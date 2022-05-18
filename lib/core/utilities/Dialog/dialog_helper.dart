import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';

class DialogHelper {
  //show error dialog
  static void showErrorDialog(
      {String title = 'Error', String? description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.sadTear,
                      color: Colors.white,
                      size: 13,
                    ),
                    AppSpaces.spaces_height_10,
                    Text(title),
                  ],
                ),
              ),
            ),
            Container(
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      description ?? '',
                      style: Get.textTheme.subtitle2,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        minimumSize: Size.zero,
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                      ),
                      onPressed: () {
                        if (Get.isDialogOpen!) Get.back();
                      },
                      child: Text('Okay'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }

  static void showLoading([String? message]) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 8),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }
}

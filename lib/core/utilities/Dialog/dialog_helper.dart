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
        backgroundColor: AppColors.backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              20.0,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.graphGradient,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    20.0,
                  ),
                  topRight: Radius.circular(
                    20.0,
                  ),
                ),
              ),
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.sadTear,
                      color: Colors.white,
                      size: 20,
                    ),
                    AppSpaces.spaces_height_5,
                    Text(title,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      description ?? '',
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: Get.height * .05,
                      width: Get.width * .25,
                      decoration: BoxDecoration(
                        gradient: AppColors.purpleGradient, // set border width
                        borderRadius: const BorderRadius.all(
                            Radius.circular(20.0)),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (Get.isDialogOpen!) Get.back();
                        },
                        child: const Text(
                          'Okay',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )
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
              const CircularProgressIndicator(),
              const SizedBox(height: 8),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }
}

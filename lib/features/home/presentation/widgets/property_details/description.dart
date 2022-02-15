import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/home/_controller/home_controller.dart';

class PropertyDescription extends StatelessWidget {
  const PropertyDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Padding(
      padding: EdgeInsets.only(
        left: AppDimension.padding_16,
        right: AppDimension.padding_16,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            AppLanguageString.PROPERTYDESCRIPTION.tr,
            style: Get.textTheme.headline2!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSpaces.spaces_height_10,
        ],
      ),
    );
  }
}

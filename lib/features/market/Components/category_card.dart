import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';

class CategoryCard extends StatelessWidget {
  final String? name;
  final Gradient? gradient;

  const CategoryCard({
    Key? key,
    this.name,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        AppDimension.padding_8,
      ),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          gradient: gradient,
          border: Border.all(
            color: AppColors.primaryColor,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppDimension.padding_10),
          child: Text(
            name.toString(),
            textAlign: TextAlign.center,
            style: Get.textTheme.bodyText1!.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}

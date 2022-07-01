import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';

class CategoryCard extends StatelessWidget {
  final String? name;
  final String? print;
  final Gradient? gradient;

  const CategoryCard({
    Key? key,
    this.name,
    this.print,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: gradient,

        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimension.padding_10),
        child: Text(
          name.toString(),
          textAlign: TextAlign.center,
          style: Get.textTheme.bodyText1!.copyWith(color: AppColors.white,fontFamily: 'Inter',),
        ),
      ),
    );
  }
}

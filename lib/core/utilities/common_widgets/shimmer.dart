import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_assets/app_assets.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_sizes.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:shimmer/shimmer.dart';

ShimmerWidget(double height, double width, var itemCount, String type) {
  return Container(
    width: double.infinity,
    child: Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey,
      enabled: true,
      child: type == 'itemList'
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, __) => Padding(
                padding: EdgeInsets.only(
                  right: 8.0,
                ),
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20,
                            spreadRadius: 20)
                      ]),
                ),
              ),
              itemCount: itemCount,
            )
          : GridView.builder(
              itemCount: 3,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 3.0,
                crossAxisSpacing: 3.0,
                crossAxisCount: 3,
                childAspectRatio: AppSizes.width3 / 130,
              ),
              itemBuilder: (_, __) => Padding(
                padding: EdgeInsets.only(
                  right: 8.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAsset.demo_category,
                      height: AppDimension.category_image_height,
                      width: AppDimension.category_image_width,
                    ),
                    AppSpaces.spaces_height_10,
                    Padding(
                      padding: EdgeInsets.only(
                        left: AppDimension.padding_8,
                        right: AppDimension.padding_8,
                      ),
                      child: Text(
                        '.....',
                        textAlign: TextAlign.center,
                        style: Get.textTheme.bodyText1!
                            .copyWith(color: AppColors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    ),
  );
}

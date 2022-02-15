import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ketemaa/app_routes/app_routes.dart';
import 'package:ketemaa/core/utilities/app_assets/app_assets.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';

class CategoryCard extends StatelessWidget {
  List? category;
  var mainAxisSpace;
  var crossAxisSpace;
  var childCount;
  var childAspectRatio;
  var cardElavation;
  var pageName;

  CategoryCard({
    this.category,
    this.mainAxisSpace,
    this.crossAxisSpace,
    this.childAspectRatio,
    this.childCount,
    this.cardElavation,
    this.pageName,
  });

  @override
  Widget build(BuildContext context) {
    print(QueryResult.optimistic().data);
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: category!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: mainAxisSpace,
        crossAxisSpacing: crossAxisSpace,
        crossAxisCount: childCount,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
          },
          child: Card(
            elevation: cardElavation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
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
                    category![index].node.name,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.bodyText1!
                        .copyWith(color: AppColors.black),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

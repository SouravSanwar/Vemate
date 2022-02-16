import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ketemaa/app_routes/app_routes.dart';
import 'package:ketemaa/core/utilities/app_assets/app_assets.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';

class CategoryCard extends StatelessWidget {
  String? image;
  String? name;

  CategoryCard({
    this.image,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width * .4,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: Get.width * .3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      AppAsset.apartment_1,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppSpaces.spaces_height_10,
                    Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(AppDimension.padding_8),
                          bottomRight: Radius.circular(AppDimension.padding_8),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: AppDimension.padding_8,
                          right: AppDimension.padding_8,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            name.toString(),
                            textAlign: TextAlign.center,
                            style: Get.textTheme.bodyText1!
                                .copyWith(color: AppColors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
